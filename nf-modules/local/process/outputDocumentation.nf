/*
Copyright Institut Curie 2020-2021

This software is a computer program whose purpose is to
provide a demo with geniac.
You can use, modify and/ or redistribute the software under the terms
of license (see the LICENSE file for more details).
The software is distributed in the hope that it will be useful,
but "AS IS" WITHOUT ANY WARRANTY OF ANY KIND.
Users are therefore encouraged to test the software's suitability as regards
their requirements in conditions enabling the security of their systems and/or data.
The fact that you are presently reading this means that you have had knowledge
of the license and that you accept its terms.

*/


/*****************************
* Generate the documentation *
******************************/

process outputDocumentation {
    label 'python'
    label 'minCpu'
    label 'minMem'
    publishDir "${params.summaryDir}/", mode: 'copy'

    input:
    path outputDocs

    output:
    path "resultsDescription.html"

    script:
    """
    markdown_to_html.py $outputDocs -o resultsDescription.html
    """
}
