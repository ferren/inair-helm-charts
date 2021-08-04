# Inair Helm 库
包含odoo相关的helm charts仓库


## helm的chart仓库地址为：https://helm.litral.com

## 本Chart仓库的使用方法

1、添加chart仓库
```
# helm repo add inair-helm https://helm.litral.com/
```

2、添加成功
```
# helm repo list
NAME      	URL                                   
inair-helm	https://helm.litral.com/
```

3、搜索chart包
```
# helm search repo
NAME                                        	CHART VERSION	APP VERSION  	DESCRIPTION                
inair-helm/odoo                             	0.1.0        	1.16.0       	A Helm chart for Kubernetes
```

4、安装chart包
```
# helm install xxx inair-helm/odoo
```

xxx为relaese名字
