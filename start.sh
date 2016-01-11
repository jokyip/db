#!/bin/sh

root=~/prod/db
sails=`which sails`

forever start --workingDir ${root} -a -l db.log ${sails} lift --prod