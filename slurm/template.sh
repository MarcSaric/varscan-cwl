#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --workdir=/mnt/SCRATCH/

normal="XX_NORMAL_XX"
tumor="XX_TUMOR_XX"
normal_id="XX_NORMAL_ID_XX"
tumor_id="XX_TUMOR_ID_XX"
case_id="XX_CASE_ID_XX"
basedir="/mnt/SCRATCH/"
ref="s3://bioinformatics_scratch/GRCh38.d1.vd1.fa"
refindex="s3://bioinformatics_scratch/GRCh38.d1.vd1.fa.fai"
username="XX_username_XX"
password="XX_password_XX"
repository="git@github.com:NCI-GDC/varscan-cwl.git"
s3dir="s3://washu_varscan_variant/"
wkdir=`mktemp -d -p /mnt/SCRATCH` 
cd $wkdir 
sudo git clone -b feat/slurm $repository  
sudo chown ubuntu:ubuntu varscan-cwl 
cwl=$wkdir/varscan-cwl/tools/varscan-tool.cwl.yaml
/home/ubuntu/.virtualenvs/p2/bin/python $wkdir/varscan-cwl/slurm/run_cwl.py --ref $ref --refindex $refindex --normal $normal --tumor $tumor --normal_id $normal_id --tumor_id $tumor_id --case_id $case_id --username $username --password $password --basedir $basedir --cwl $cwl --s3dir $s3dir
sudo rm -rf $wkdir
