def add(*args):
    x = 0
    for el in args:
        x+=el
    print(x)
    return x

add(5,6,7)