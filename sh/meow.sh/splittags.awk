{
  str=$0
  topen="<"tag">"
  tclose="</"tag">"
  len=length(tag)
  for (;;) {
    begin=index(str, topen)
    end=index(str,tclose)
    if (!(begin || end)) break
    print substr(str, begin+len+2, end-begin-len-2)
    str=substr(str, end+len+3)
  }
}
