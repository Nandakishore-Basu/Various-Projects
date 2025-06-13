# Codes in different programming languages

## For Addition

### Function which may take as many numers it wants

#### By Nandakishore Basu

##### PYTHON, JAVASCRIPT, C, DART

###### Easiest : Python

```py
def add(*args):
    x = 0
    for el in args:
        x+=el
    print(x)
    return x

add(5,6,7) #python
```

```js
function add(...args) {
    let x = 0
    for (const num of args) {
        x+=num
    }
    console.log(x)
    return x
}

add(5,6,7) //javascript
```

```c
#include<stdio.h>

double add(double args[], int size){
    double x = 0;
    for (int i = 0; i<size ; i++){
       x+=args[i];
    }
    
    printf("%f", x);
    return x;
}

int main(){
    double nums[] = {5,6,7};
    add(nums, sizeof(nums)/sizeof(nums[0]));
    return 0;
} //c
```

```dart
add(List<double> args) {
  double x = 0;
  for (double number in args) {
    x += number;
  }
  print(x);
  return x;
}

void main() {
  add([5, 6, 7]);
} //dart
```