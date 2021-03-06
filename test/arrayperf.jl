n_evals = 1e7
run_ref = true
run_assign = true

if run_ref
    println("#### Ref ####")
    println("Whole array operations:")
    println("Small arrays:")
    lensmall = 4
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        A = rand(sz)
        n_r = iceil(n_evals/prod(sz))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            B = A[:]
        end
    end
    println("Big arrays:")
    lenbig = [1000000,1000,100,32,16,10,10]
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        A = rand(sz)
        n_r = iceil(n_evals/prod(sz))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            B = A[:]
        end
    end
    println("\n")
    
    println("Slicing with contiguous blocks:")
    println("Small arrays:")
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        A = rand(sz)
        ind = ntuple(n_dims,i -> ((i <= ceil(n_dims/2)) ? (1:sz[i]) : (randi(sz[i]))))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
            B = A[ind...]
        end
    end
    println("Big arrays:")
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        A = rand(sz)
        ind = ntuple(n_dims,i -> ((i <= ceil(n_dims/2)) ? (1:sz[i]) : (randi(sz[i]))))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
            B = A[ind...]
        end
    end
    println("\n")

    println("Slicing with non-contiguous blocks:")
    println("Small arrays:")
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        A = rand(sz)
        ind = ntuple(n_dims,i -> ((i > n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
            B = A[ind...]
        end
    end
    println("Big arrays:")
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        A = rand(sz)
        ind = ntuple(n_dims,i -> ((i > n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
            B = A[ind...]
        end
    end
    println("\n")


    println("Random operations:")
    println("Small arrays:")
    function randind(len)
        i = randi(6)
        indchoices = {1:len,1:iceil(len/2),1:iceil(3*len/4),2:2:len,1:iceil(len/2):len,len:-1:1}
        return indchoices[i]
    end
    #indsmall = {1:4,1:2,1:3,2:2:4,1:3:4,4:-1:1}
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        A = rand(sz)
        ind = ntuple(n_dims,i->randind(sz[i]))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i->randind(sz[i]))
            B = A[ind...]
        end
    end
    println("Big arrays:")
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        A = rand(sz)
        ind = ntuple(n_dims,i->randind(sz[i]))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i->randind(sz[i]))
            B = A[ind...]
        end
    end
end

if run_assign
    println("\n\n\n#### Assign ####")
    println("Whole array operations:")
    println("Small arrays:")
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        B = zeros(sz)
        A = rand(sz)
        n_r = iceil(n_evals/prod(sz))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            B[:] = A
        end
    end
    println("Big arrays:")
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        B = zeros(sz)
        A = rand(sz)
        n_r = iceil(n_evals/prod(sz))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            B[:] = A
        end
    end
    println("\n")

    println("Slicing with contiguous blocks:")
    println("Small arrays:")
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        B = zeros(sz)
        ind = ntuple(n_dims,i -> ((i <= ceil(n_dims/2)) ? (1:sz[i]) : (randi(sz[i]))))
        A = rand(map(length,ind))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
    #        ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
    #        A = rand(map(length,ind))
            B[ind...] = A
        end
    end
    println("Big arrays:")
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        B = zeros(sz)
        ind = ntuple(n_dims,i -> ((i <= ceil(n_dims/2)) ? (1:sz[i]) : (randi(sz[i]))))
        A = rand(map(length,ind))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
#            ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
            #        A = rand(map(length,ind))
            B[ind...] = A
        end
    end
    println("\n")

    println("Slicing with non-contiguous blocks:")
    println("Small arrays:")
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        B = zeros(sz)
        ind = ntuple(n_dims,i -> ((i > n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
        A = rand(map(length,ind))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
            #        A = rand(map(length,ind))
            B[ind...] = A
        end
    end
    println("Big arrays:")
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        B = zeros(sz)
        ind = ntuple(n_dims,i -> ((i > n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
        A = rand(map(length,ind))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i -> ((i <= n_dims/2) ? (1:sz[i]) : (randi(sz[i]))))
            #        A = rand(map(length,ind))
            B[ind...] = A
        end
    end
    println("\n")


    println("Random operations:")
    println("Small arrays:")
    function randind(len)
        i = randi(6)
        indchoices = {1:len,1:iceil(len/2),1:iceil(3*len/4),2:2:len,1:iceil(len/2):len,len:-1:1}
        return indchoices[i]
    end
    #indsmall = {1:4,1:2,1:3,2:2:4,1:3:4,4:-1:1}
    for n_dims in 1:10
        sz = ntuple(n_dims,i->lensmall)
        B = zeros(sz)
        ind = ntuple(n_dims,i->randind(sz[i]))
        A = rand(map(length,ind))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i->randind(sz[i]))
            #        A = rand(map(length,ind))
            B[ind...] = A
        end
    end
    println("Big arrays:")
    for n_dims in 1:length(lenbig)
        sz = ntuple(n_dims,i->lenbig[n_dims])
        B = zeros(sz)
        ind = ntuple(n_dims,i->randind(sz[i]))
        A = rand(map(length,ind))
        n_r = iceil(n_evals/prod(map(length,ind)))
        print(n_dims, " dimensions (", n_r, " repeats): ")
        @time for i = 1:n_r
            #        ind = ntuple(n_dims,i->randind(sz[i]))
            #        A = rand(map(length,ind))
            B[ind...] = A
        end
    end
end