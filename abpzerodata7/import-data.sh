#!/bin/bash

echo "---------------启动mssql...."
sleep 60s
echo "---------------查看sqlservr状态...."
ps -ef|grep sqlservr

echo "---------------开始导入数据...."
# 加花括号是为了帮助解释器识别变量的边界
databasepath="/var/opt/mssql/data/${MSSQL_DATABASE}.mdf"
databaselogpath="/var/opt/mssql/log/init${MSSQL_DATABASE}.log"

#导入数据
if [ -f $databasepath ]; then
  echo "---------------数据库已存在，中止导入...."
else
  echo "---------------import-data.sh exec ${MSSQL_EXECSQLPATH}"
  /opt/mssql-tools/bin/sqlcmd -S localhost -U "sa" -P $SA_PASSWORD -d "master" -i $MSSQL_EXECSQLPATH -o $databaselogpath
 
  echo '---------------import-data.sh exec sql'
  /opt/mssql-tools/bin/sqlcmd -S localhost -d $MSSQL_DATABASE -U SA -P $SA_PASSWORD -I -Q "select * from [dbo].[AbpUsers];"

  echo "---------------导入数据完毕...."
fi
  echo "---------------mssql容器启动完毕"
  echo "输出环境变量"
  echo $databasepath
  echo $databaselogpath
  echo $MSSQL_EXECSQLPATH
  # echo $SA_PASSWORD
  echo $MSSQL_DATABASE
# docker容器的主线程（dockfile中CMD执行的命令）结束，容器会退出
# 一直运行，但是日志不会再输出
tail -f /dev/null
