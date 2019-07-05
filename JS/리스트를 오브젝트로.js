/* list to object */
let list1 = [
    ['make', 'food'],
    ['model', 'mustang'],
    ['year', 1964]
];
let list2 = [
    ['puppy', 'woof-woof'],
    ['kitty', 'meow'],
    ['today', 190706]
];

//방법1
function convertListToObject1(list) {
    let obj1 = {};
    list.map((i) => { obj1[i[0]] = i[1]; });
    return obj1;
}
//방법2
function convertListToObject2(list) {
    let obj2 = {};
    for (i = 0; i < list.length; i++)
        obj2[list[i][0]] = list[i][1];
    return obj2;
}

function check() {
    console.log(convertListToObject1(list1));
    console.log(convertListToObject2(list2));
}
