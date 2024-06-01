//-- ? Process template great for not partitioned jobs

import groovy.yaml.YamlSlurper


process proc_minimization{
    // debug true
    label 'decent_gpu' //-- * This makes it use enough_cpi directive from nextflow.config
    tag "amber minimization"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/${minim_vals.id}/1_minimization", mode: 'copy', overwrite: true
   

    // conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"


    input:
        val(minim_vals)


    output:
       path("minimized.nc") //-- ? Copy only files don't copy directories
       path("mdout*")

    //-- TODO not good enough for job wise it does in the folder
    script:
    """
    echo ${minim_vals.id}
    pmemd.cuda -O -i ${params.project_folder}/1_minimization/min.in \
        -p ${minim_vals.param} \
        -c ${minim_vals.coord} \
        -ref ${minim_vals.coord} \
        -r minimized.nc -o mdout
    """
}



process proc_heating{
    // debug true
    label 'decent_gpu' //-- * This makes it use enough_cpi directive from nextflow.config
    tag "amber heating"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/${proj_vals.id}/2_heating", mode: 'copy', overwrite: true
   

    // conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"


    input:
        val(proj_vals)
        path(minimized_nc)


    output:
       path("heated.nc") //-- ? Copy only files don't copy directories
       path("heat_mdout")

    //-- TODO not good enough for job wise it does in the folder
    script:
    """
    echo ${proj_vals.id}
    pmemd.cuda -O -i ${params.project_folder}/2_heating/heat.in \
        -p ${proj_vals.param} \
        -c ${minimized_nc} \
        -ref ${proj_vals.coord} \
        -r heated.nc -o heat_mdout
    """
}



process proc_equilibration_1{
    // debug true
    cache true
    label 'enough_cpu' //-- * This makes it use enough_cpi directive from nextflow.config
    tag "amber equilibration 1"

    //-- * This copies the outputs of the computations to the directory
    publishDir "${params.output_folder}/${proj_vals.id}/3_equilibration", mode: 'copy', overwrite: true
   

    // conda "/home/${params.cluster_user}/a/conda_envs/lib_grab"

    beforeScript 'module load cpu/0.15.4 gcc/9.2.0 openmpi/3.1.6 amber/20'

    input:
        val(proj_vals)
        path(heated_nc)


    output:
       path("equilibration_1.nc") //-- ? Copy only files don't copy directories
       path("equilibration_1.log")

    //-- TODO not good enough for job wise it does in the folder mpirun -np 4 
    script:
    """
    echo ${proj_vals.id}
    pmemd.MPI -O -i ${params.project_folder}/3_equilibration/equilibrate_1.in \
        -p ${proj_vals.param} \
        -c ${heated_nc} \
        -ref ${proj_vals.coord} \
        -r equilibration_1.nc \
        -o equilibration_1.log
    """
}







workflow {

    println " Info> Script directory path: ${projectDir}"
    println " Info> Launch directory path: ${launchDir}"

    //-- ? How to parse from yaml
    //-- ? https://stackoverflow.com/questions/77078419/nextflow-how-to-pass-the-yaml-format-input-file-from-an-argument-to-channel-as


    inputs = new YamlSlurper().parse(file(params.inputs_list))
    Channel
        .fromList(inputs['projects'])
        .ifEmpty { ['id':params.id, 'param': params.param, 'coord': params.coord] }
        .set { projects }

    projects.view()


    //-- * Stage 1: Minimization
    minimization_task = proc_minimization(projects)

    //-- * Stage 2: Heating
    heat_task = proc_heating(projects, minimization_task[0])

    //-- * Stage 3: Equilibration 1
    equilibration_1_task = proc_equilibration_1(projects, heat_task[0])
}
