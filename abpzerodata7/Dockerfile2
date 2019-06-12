FROM mcr.microsoft.com/mssql/server:2017-latest

LABEL author="netcorevip"
LABEL email="netcorevip@outlook.com"

# 容器内创建目录
RUN mkdir -p /usr/src/app

# 设置为工作目录
WORKDIR /usr/src/app

# 复制当前目录所有文件到容器目录
COPY . /usr/src/app

# 设置sh脚本执行权限
RUN chmod +x /usr/src/app/import-data.sh

# 数据库排序规则
ENV MSSQL_COLLATION=Chinese_PRC_CI_AS
# 数据库语言区域
ENV MSSQL_LCID=2052
# 数据名称
ENV MSSQL_DATABASE=AbpZeroTemplateDb
# 执行数据导入脚本路径
ENV MSSQL_EXECSQLPATH=/usr/src/app/ABPZero7_Data.sql
# 容器数据区域  
ENV TZ=Asia/Shanghai

# 容器启动执行脚本
CMD /bin/bash ./entrypoint.sh