#!/bin/bash
for f in `ls`; do tesseract $f $f ; done
en_result=`cat *.txt | grep  -A5 'You:'  | grep -Ev "\-\-|^$|Oo|ok SC"`
## 用gpt4o整理一下学习的列表: 提示词 =>
request_gpt4-o_api "
整理下列英语语料，列出来一个英语句子学习列表，
要求：纠正语法错误，去除重复的句子。
英语语料如下： ${en_result}
"

