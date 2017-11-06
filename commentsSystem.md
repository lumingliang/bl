title:  实现多说评论的方法
1. 利用现成的平台如，国内的多说，
2. 之前的解决方案总结。

##### 讲解多级评论系统的解决方案

关键操作是：redis数据结构，然后是储存，接着是怎么取出且缓存成数组(这个数组结构是怎么样的)，然后是怎么历遍打出

redis 键值结构

```
$ 表示变值
items:$id key代表任意一篇文章的id, value 应该是该items的内容
key: items:$id:comments  value: 存着所有在该items下的直接子comment id,不包括多级

key: thread:$parentId:comments value: 每个父评论都可以储存着它的所有的子评论,不包括多级

key: commet:id  value: 关键value为它自己的评论内容，和父id，以及itemid

key: parseComment value 储存着一个数组，该数组保存着一个已经取出的评论集，方便下次查的时候，不用重新解析。

```

这样下来，每个评论都可以看做是平级的，只是它储存着父评论id，知道评论id可以查找它的父评论，和所属文章；但是知道父评论怎么查找它的子评论呢，于是就用了thread来保存它的直系子评论，这样就可以通过级联（递归）实现互相查询了

储存时候，的逻辑是，每次储存，根据给定的新增，知道新增评论的所属itemId和所属parent comment id ,然后开始插入。

取出时，缓存的结构类似，目录树，只不过它是一个数组的形式
第一层 2层 3层

第一层储存的内容是，parentId[0] xxx parentId因为在第一层，所以是itemId,然后0 - n分别是第一级评论的主体内容，然后其他元素是以当前commentId为key，值是连接下一级的所有内容,之后每一级都一样
