#!/bin/sh

# Dashboard installation (https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml


# get secret token
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"


# Ingress Controller Install
helm install ingress-nginx-2 ingress-nginx/ingress-nginx
--namespace ingress-nginx-2
--set controller.ingressClassResource.name=nginx-2
--set controller.ingressClassResource.controllerValue="k8s.io/ingress-nginx-2"
--set controller.ingressClassResource.enabled=true
--set controller.ingressClassByName=true
