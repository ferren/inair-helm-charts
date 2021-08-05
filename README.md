# Inair Helm 库
包含odoo相关的helm charts仓库


## helm的chart仓库地址为：https://ferren.github.io/inair-helm-charts/

## 本Chart仓库的使用方法

1、添加chart仓库
```
# helm repo add inair-helm https://ferren.github.io/inair-helm-charts/
```

2、添加成功
```
# helm repo list
NAME      	URL                                   
inair-helm	https://ferren.github.io/inair-helm-charts/
```

3、搜索chart包
```
# helm search repo
NAME                 	CHART VERSION	APP VERSION	DESCRIPTION                                       
inair-helm/common    	1.7.1        	1.7.1      	A Library Helm Chart for grouping common logic ...
inair-helm/odoo      	0.1.0        	1.16.0     	A Helm chart for Kubernetes                       
inair-helm/postgresql	1.0.0        	13.3.0     	Chart for PostgreSQL, an object-relational data...
```

4、安装chart包
```
# helm install xxx inair-helm/postgresql
```

xxx为relaese名字
