ps  #list all process of current user
ps -ef #list all processes in detail format
ps aux #tương tự ps -ef nhưng có thêm thong tin thời gian start, cpu time consume.
ps -e #list all process không quan tâm ai là owner.
ps -l #list process dưới dạng format dài.
kill <process-ID> #hoặc 
kill -9 <process-ID> #để force kill 1 process.
