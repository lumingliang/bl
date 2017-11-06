##### 有限级别树形结构

数据库形式

table parent
id value

table child
id value parentId

table child1
id value child1Id

每次可以根据parent id 取出它子级的所有元素，至少需要返回id value

数组形式
[
    'idP1' => [
        'id' => 1, // 可省略
        'value' => 'val',
        'child' => [
            'childId1' => [
                'id' => 1,
                'value' => 'val',
            ],
            'childId2' => [
                'id' => 2,
                'value' => 'val',
                'child' => ...
            ],
        ],
    ],
    'idP2' => [
        'id' => 2,
        'value' => 'val',
    ]
]

**如果没有id对应，那么value可以直接充当id
取出用 ['id']['child']['id']['child']


{
    "name": "1级菜单1",
    "link": "###",
    "isleaf": false,
    "level": 0,
    "children": [
        {
            "name": "2级菜单1",
            "link": "###",
            "isleaf": false,
            "level": 1,
            "children": [
                {
                    "name": "3级菜单1",
                    "link": "###",
                    "isleaf": true,
                    "level": 2,
                    "children": null
                },
                {
                    "name": "3级菜单2",
                    "link": "###",
                    "isleaf": true,
                    "level": 2,
                    "children": null
                }
            ]
        },
        {
            "name": "2级菜单2",
            "link": "###",
            "isleaf": false,
            "level": 1,
            "children": [
                {
                    "name": "3级菜单3",
                    "link": "###",
                    "isleaf": true,
                    "level": 2,
                    "children": null
                }
            ]
        }
    ]
}
