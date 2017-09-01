#!/usr/bin/env cwl-runner

cwlVersion: v1.0

doc: |
    Run SAMtools mpileup

requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: quay.io/ncigdc/samtools:9bbccff355bf

class: CommandLineTool

inputs:
  - id: ref
    type: File
    inputBinding:
      position: 1
      prefix: -f
    secondaryFiles:
      - '.fai'

  - id: region
    type: string
    inputBinding:
      position: 2
      prefix: -r

  - id: normal_bam
    type: File
    inputBinding:
      position: 3
    secondaryFiles:
      - '^.bai'

  - id: tumor_bam
    type: File
    inputBinding:
      position: 4
    secondaryFiles:
      - '^.bai'

  - id: output
    type: string
    inputBinding:
      position: 5
      prefix: ">"

outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: $(inputs.output)

baseCommand: ['samtools', 'mpileup']
