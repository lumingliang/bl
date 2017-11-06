```sh
#!/bin/sh#sorting following arrayecho "please input a number list:"read -a arrfor (( i=0 ; i<${#arr[@]} ; i++ ))do  for (( j=${#arr[@]} - 1 ; j>i ; j-- ))  do    #echo $j    if  [[ ${arr[j]} -lt ${arr[j-1]} ]]    then       t=${arr[j]}       arr[j]=${arr[j-1]}       arr[j-1]=$t    fi  donedoneecho "after sorting:"
```

my_list = [12, 5, 13, 8, 9, 65]

def bubble(bad_list):
    length = len(bad_list) - 1
    sorted = False

    while not sorted:
        sorted = True
        for i in range(length):
            if bad_list[i] > bad_list[i+1]:
                sorted = False
                bad_list[i], bad_list[i+1] = bad_list[i+1], bad_list[i]

bubble(my_list)
print my_list


