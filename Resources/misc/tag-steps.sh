#!/bin/bash

declare -a commits=(
    "Create the bundle"
    "Structure the bundle"
    "Implement the Tweet\\\Value class"
    "Implement the Tweet\\\Type class"
    "Register the Field Type as a service"
    "Implement the Legacy Storage Engine Converter"
    "Add field view and field definition view templates"
    "Add content and edit views"
    "Add a validation"
    )
declare -a tags=(
    "step1_create_the_bundle"
    "step2_structure_the_bundle"
    "step3_implement_the_tweet_value_class"
    "step4_implement_the_tweet_type_class"
    "step5_register_the_field_type_as_a_service"
    "step6_implement_the_legacy_storage_engine_converter"
    "step7_add_field_view_and_field_definition_view_templates"
    "step8_add_content_and_edit_views"
    "step9_add_a_validation"
    )

numberOfCommits=${#commits[@]}

for (( i=0; i<${numberOfCommits}; i++ ));
do
    git tag -d "${tags[$i]}" 2> /dev/null
    SHA1=`git log --oneline --grep "${commits[$i]}" | cut -d" " -f1`
    if [ ${SHA1} ] ; then
        git tag "${tags[$i]}" ${SHA1}
    fi
done

echo "Tags created."

read -p "Do you want to push tags to a remote repository? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git push --tags --force
    echo "Tags pushed."
fi
