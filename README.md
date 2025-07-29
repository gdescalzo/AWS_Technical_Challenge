[[_TOC_]]


# Solution overview


![Cloud_Services_AWS_Tech_Challenge-jul2025](img/Cloud_Services_AWS_Tech_Challenge-jul2025-1.pdf)
![Cloud_Services_AWS_Tech_Challenge-jul2025](img/Cloud_Services_AWS_Tech_Challenge-jul2025-2.pdf)
![Cloud_Services_AWS_Tech_Challenge-jul2025](img/Cloud_Services_AWS_Tech_Challenge-jul2025-3.pdf)
![Cloud_Services_AWS_Tech_Challenge-jul2025](img/Cloud_Services_AWS_Tech_Challenge-jul2025-4.pdf)

| Note | The following challenge has been develop in Windows 11 platform, so the following tools are required to reproduce the development and use the solution. Taking in consideration the challenge scope has been develop two solutions <br /><br /> 1. to be executed local <br /> 2. to be executed remote |
|-|:-|




## Pre-requisites

> Please find bellow the pre-requisites

<details>
<summary>GitHub account</summary>

> The GitHub account is easly to be created, you can just go to [www.github.com](https://www.github.com).
> If you need more information about the GitHub account creation process, please refer to: [Creating an account on GitHub](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github)

</details>

<details>
<summary>Text editor</summary>

> For this challenge I been choised to use vsCode, you can download directly from:
> If you wana know more about the installation process you can go to the following link: [Visual Studio Code on Windows](https://code.visualstudio.com/docs/setup/windows)

</details>

<details>
<summary>Terraform</summary>

</details>

<details>
<summary>AWS account (optional)</summary>

</details>


## Best practises

> Sabiendo que este challenge es utilizado para determinar las habilidades de un ingeniero de cloud en un entorno laboral, es recomendado, pero no mandatorio seguir ciertos lineamientos de diseño y seguridad. A continuacion puede encontrar las configuraciones necesarias en las plataformas AWS, GitHub y Terraform con el de preparar el ambiente para la ejecusion de la prueba de concepto.

<details>
<summary>GitHub best practises.</summary>

1. create a privated repository: the purpose of this is onece you already consolidate the solution, then make it public.
2. create more of one branch: en ambientes profesionales, and as a best practise, is not common work and test on the same enviroment, because is not safe and can cause disrruptions over the service. El codigo producido debe ser revisado y aprobado antes de mergearse en la rama principal, por lo tanto al momento del desarrollo de esta actividad se considero, desarrolla en una rama llamada DEV y una vez realizado el desarrollo atravez de un pull request, mergear a main.
3. create secrets: crear secretos en el proyecto de GitHub con el  fin de almacenar las credenciales de AWS para ejecusion remota.

</details>

<details>
<summary>AWS best practises.</summary>

1. No utilizar el usuario root, crear una cuenta admin.
2. Definir metodo de autenticacion para GitHub
3. Crear role para Terraform
4. definir politicas para el role Terraform, solo dandole privilegios para lo que debe realizar.
5. Realizar integracion entre AWS y GitHub
6. Instalar AWS Cli en Windows 11 a fin de primero desarrollar localmente
7. Instalar Terraform en Windows 11 a fin de poder testear el codigo y el aprovisionamiento correcto de los recursos en AWS.

</details>

## Deployment instructions

## Design decisions and assumptions

## References to resources used

## Assumptions made

## Improvement plan with priorities

## Analysis of operational gaps

## Solutions Diagram

| **Clarification**: The following SD is properly formatted and styled diagram against AWS diagram standards. |
|-|

**Content**

o All deployed components identified
o Connectivity/dataflow’s identified

## Terraform configurations

Please find below Terraform solution diagram content




- [VPC Launch](#vpc-launch)
  - [VPC Components](#vpc-components)
  - [Terraform Modules](#terraform-modules)

  <hr />

# VPC Launch

> This repo insted to had a basic network infrastructure. The basical idea it´s have two Subnets, one public and other privated with an Internet gateway (_igw_) connected to the public one. And the routing table that permit 0.0.0.0/0 traffic between the public subnet and the igw.

An overview of what will be created on AWS onece execute the terraform manifiest.

![vpc_map.png](./img/vpc_map.png)

## VPC Components

1. VPC (_10.0.0.0/16_)
2. Public Subnet (_10.0.1.0/24_)
3. Private Subnet (_10.0.2.0/24_)
4. Public Routing Table (_Public Subnet <-> 0.0.0.0/0_)
5. Security group (_Allow traffic to '80','443','22','3389'_)

### VPC

> This module will help you to create a default VPC, with a default addressing (10.0.0.0/16) no bigger configurations should have to do here only you can change the Region and the addres that you want from here

```
\
│   main.tf
│   outputs.tf
│   README.md
│   variables.tf <-- HERE you can change the VPC addressing and the Region.
│ 
```

### Public Subnet

> This subnet at the moment to be created is just a privated subnet with the name "public", only will be public if is associated to an Internet Gateway for example.
> The creation and modification over the public subnete, can be made on the "variables.tf" root file, you can change the IP, Name and Availability Zone.

```
\
│   main.tf
│   outputs.tf
│   README.md
│   variables.tf <-- HERE you can change the Public Subnets configuration.
│ 
```


## Terraform Modules

```
\
│   main.tf
│   outputs.tf
│   README.md
│   variables.tf
│   
├───img
│       vpc_map.png
│
└───modules
    ├───igw
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───routing_table
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───sg
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───subnets
    │       main.tf
    │       output.tf
    │       variables.tf
    │
    └───vpc
            main.tf
            output.tf
            variables.tf
```
