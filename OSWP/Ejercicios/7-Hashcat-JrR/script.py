from itertools import permutations, product
        words = ["bird","cat","dog"]
        with open("/tmp/mangled.txt","w") as f:
                for r in (2,3):
                        for perm in permutations(words, 3):
                                for nums in product("0123456789", repeat=r):
                                        f.write("".join(perm) + "".join(nums) + "\n")
