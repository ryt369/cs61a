def search(f):
    x=0
    while True:
        if f(x):
            return x
        x +=1
def is_three(x):
    return x==3
print(search(is_three))
def square(x):
    return x*x
def inverse(f):
    '"找到f的反函数，即找到g使得g(f(x))=x"'
    return lambda y:search(lambda x:f(x)==y)
sqrt=inverse(square)
print(sqrt(4))