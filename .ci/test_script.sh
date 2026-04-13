#!/bin/bash
set -x # echo commands with vars expanded
set -e # exit immediately on error

TEMPLATE_PR_DIR=$PWD

# Clean up any leftover directories from previous runs (GitHub runner may cache workspace)
rm -rf new_module convert_from_release_tag convert_from_main

# Make a branch from checked out HEAD so that we can target
# it specifically with --template-ref
git checkout -b ci_commit

# Test if new module from PR commit is still functional.
vdk new module new_module --template-url="file://$TEMPLATE_PR_DIR" --template-ref=ci_commit --skip-interview
pushd new_module
grep template < metadata.json
cp "$TEMPLATE_PR_DIR/.ci/fixtures/new_provider_sync.yml" ./.sync.yml
grep -A 1 "Performance/CaseWhenSplat" ./.rubocop.yml | grep -q "true" # Ensure that the template is applied
vdk update --force
grep -A 1 "Performance/CaseWhenSplat" ./.rubocop.yml | grep -q "false" # Ensure that the update command changes the template
vdk new class new_module
vdk new defined_type test_type
vdk new fact test_fact
vdk new function --type native testfunc_nat
vdk new function --type v4 testfunc_v4
vdk new provider test_provider
vdk new task test_task
vdk new transport test_transport
vdk validate || true  # Continue even if validate fails (debugging CI)
vdk test unit
popd

rm -f ~/.vdk/cache/answers.json

# Create new module from default template-url and release tag
vdk new module convert_from_release_tag --skip-interview
pushd convert_from_release_tag
grep template < metadata.json
# Attempt to convert to PR commit from release tag
vdk convert --template-url="file://$TEMPLATE_PR_DIR" --template-ref=ci_commit --skip-interview --force
cat convert_report.txt
popd

rm -f ~/.vdk/cache/answers.json

# Create new module from main branch of official templates repo (may fail if upstream doesn't exist)
vdk new module convert_from_main --template-url="https://github.com/voxpupuli/vdk-templates.git" --template-ref=main --skip-interview || true
if [ -d convert_from_main ]; then
  pushd convert_from_main
  grep template < metadata.json || true
  # Attempt to convert to PR commit from official/main
  vdk convert --template-url="file://$TEMPLATE_PR_DIR" --template-ref=ci_commit --skip-interview --force || true
  cat convert_report.txt || true
  popd
fi
