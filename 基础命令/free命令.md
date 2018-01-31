## 怎么用 free 命令查看已使用和未使用的内存？
这很容易，您只需不加任何参数地运行 free 这条命令就可以了：
```
free
```


## 输出的列是什么意思呢？

> total - 安装的内存的总量（等同于 /proc/meminfo 中的 MemTotal 和 SwapTotal）

> used - 已使用的内存（计算公式为：used = total - free - buffers - cache）

> free - 未被使用的内存（等同于 /proc/meminfo 中的 MemFree 和 SwapFree）

> shared - 通常是临时文件系统使用的内存（等同于 /proc/meminfo 中的 Shmem；自内核 2.6.32 版本可用，不可用则显示为 0）

> buffers - 内核缓冲区使用的内存（等同于 /proc/meminfo 中的 Buffers）

> cache - 页面缓存和 Slab 分配机制使用的内存（等同于 /proc/meminfo 中的 Cached 和 Slab）

> buff/cache - buffers 与 cache 之和

> available - 在不计算交换空间的情况下，预计可以被新启动的应用程序所使用的内存空间。与 cache 或者 free 部分不同，这一列把页面缓存计算在内，并且不是所有的可回收的 slab 内存都可以真正被回收，因为可能有被占用的部分。（等同于 /proc/meminfo 中的 MemAvailable；自内核 3.14 版本可用，自内核 2.6.27 版本开始模拟；在其他版本上这个值与 free 这一列相同）

## 如何更改显示的单位呢？

如果需要的话，你可以更改内存的显示单位。比如说，想要内存以兆为单位显示，你可以用 -m 这个参数：
```
free -m
free command display metrics change

free command display metrics change
```
同样地，你可以用 -b 以字节显示、-k 以 KB 显示、-m 以 MB 显示、-g 以 GB 显示、--tera 以 TB 显示。

## 怎么显示可读的结果呢？
free 命令提供了 -h 这个参数使输出转化为可读的格式。
```
free -h
```
用这个参数，free 命令会自己决定用什么单位显示内存的每个数值。例如：

diplsy data fromm free command in human readable form

## 怎么让 free 命令以一定的时间间隔持续运行？
```
您可以用 -s 这个参数让 free 命令以一定的时间间隔持续地执行。您需要传递给命令行一个数字参数，做为这个时间间隔的秒数。
```
例如，使 free 命令每隔 3 秒执行一次：
```
free -s 3
```

如果您需要 free 命令只执行几次，您可以用 -c 这个参数指定执行的次数：
```
free  -c 5
```


## 如何使 free 命令显示每一列的总和？
如果您想要 free 命令显示每一列的总和，你可以用 -t 这个参数。
```
free -t
```
