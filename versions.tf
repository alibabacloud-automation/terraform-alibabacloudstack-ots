terraform {
  required_version = ">= 0.13"
  required_providers {
    alibabacloudstack = {
      source  = "aliyun/alibabacloudstack"
      #version = ">= 4.64, < 7"
    }
  }
}