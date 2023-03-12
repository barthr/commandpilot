#!/usr/bin/env bash

# A couple of things are required for this to one run
# One: you need an OPENAI_API_KEY, otherwise it is is not possible for the script to generate the responses
# Second: you need to have Gum (https://github.com/charmbracelet/gum) installed since it is used to make the script easily interactive
# Third: you need to have jq (https://stedolan.github.io/jq/) installed

if [ -z "$OPENAI_API_KEY" ]; then
    echo "Required environment variable OPENAI_API_KEY not found, please set is."
    exit 1
fi

if ! command -v gum &> /dev/null
then
    echo "Gum is not found. Please install gum from https://github.com/charmbracelet/gum"
    exit
fi

if ! command -v jq &> /dev/null
then
    echo "jq is not found. Please install jq from https://stedolan.github.io/jq/"
    exit
fi

get_chatgpt_response() {
    # command in single quotes followed by the explanation separated by an hyphen. Provide only this and nothing more
    question="Provide an command for the following description between single quotes: '$1' provide 4 solutions as json objects (with keys: command and explanation) and include the command and an explanation of 5 words on what it does restrict both of them to a single line, return the results in a json array"

    gum spin --spinner points --show-output --title "Responding..." -- curl -s https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
    \"model\": \"gpt-3.5-turbo\",
    \"messages\": [{\"role\": \"assistant\", \"content\": \"$question\"}] 
    }"
}

output_file=/tmp/command-pilot-output.txt
command_question=$(gum input --placeholder "What command would you like help with?")
response=`get_chatgpt_response "$command_question" | jq -r '.choices[0].message.content'`
echo $response | jq -r '.[] | "\(.command) \("# ")\(.explanation)"' > $output_file
$(cat $output_file | gum filter | sed 's![^#]*$!!' | sed 's/.$//')

