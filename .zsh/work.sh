new_work(){
pushd ${work}
if [ ! -d $1 ]; then
   mkdir $1
   touch $1/TODO.org
   cd $1
fi
if [ $2 ]; then
   mkdir $2
   cd $2
fi
}

new_project(){
pushd ${Repositories}
if [ ! -d $1 ]; then
   mkdir $1
   touch $1/TODO.org
   cd $1
   git init
else
    echo "please provide project name"
fi
}

database_size(){
    echo "SELECT
     table_schema as `Database`,
     table_name AS `Table`,
     round(((data_length + index_length) / 1024 / 1024/1024), 2) `Size in GB`
FROM information_schema.TABLES
ORDER BY (data_length + index_length) DESC;"
}
