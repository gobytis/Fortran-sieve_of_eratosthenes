!> エラトステネスのふるいを実行するクラスです。
module class_sieve_of_eratosthenes
    use, intrinsic :: iso_fortran_env
    implicit none

    private

    !> エラトステネスのふるいを実行するクラスです。
    type, public :: sieve_of_eratosthenes

        contains

        procedure, public, pass :: sieve
    end type


    contains


    !> 指定の自然数以下の素数を格納した int32 配列を返します。
    !> 該当する素数が存在しない場合は大きさ 0 の配列を返します。
    function sieve(this, upper_limit) result(prime_number_array)
        ! 引数
        !> この手続きを実行するインスタンス (指定不要)
        class(sieve_of_eratosthenes), intent(in) :: this
        !> 走査する自然数の上限
        integer(int32), intent(in) :: upper_limit
        ! 戻り値
        !> 指定の自然数以下の素数を格納した int32 配列
        integer(int32), allocatable :: prime_number_array(:)
        ! ループ カウンタ
        integer(int32) i

        ! upper_limit が 0 以下であればエラーを表示し、大きさ 0 の配列を返します。
        if (upper_limit <= 0) then
            write(error_unit, *) "ERROR : upper_limit must be positive."
            write(error_unit, *) "An empty int32 array is returned."
            allocate(prime_number_array(0))
            return
        end if

        ! 素数を配列に格納します。
        prime_number_array = pack([(i, i = 1, upper_limit)], mask = is_prime_number(upper_limit))
    end function


    !> インデックス i が素数なら要素が true である論理型配列を初期化します。
    function initialize_prime_number_flag(array_size) result(is_prime_number)
        ! 引数
        !> array_size 論理型配列の大きさ
        integer(int32), intent(in) :: array_size
        ! 戻り値
        !> インデックス i が素数なら true である論理型配列
        logical, allocatable :: is_prime_number(:)

        ! input_number 以下の整数が素数であるかを判定する論理型配列を生成します。
        allocate(is_prime_number(array_size), source = .true.)
        ! 1 を素数から外します。
        is_prime_number(1) = .false.

        ! array_size が 1 であれば終了します。
        if (array_size == 1) return

        ! 2 を素数と判定します。
        is_prime_number(2) = .true.

        ! array_size が 2 であれば終了します。
        if (array_size == 2) return

        ! array_size が 4 以上の場合
        if (array_size >= 4) then
            ! 2 より大きい偶数を素数でないと判定します。
            is_prime_number(4:array_size:2) = .false.
        end if
    end function


    !> インデックス i が素数なら要素が true である、指定の大きさの論理型配列を返します。
    function is_prime_number(array_size) result(is_prime)
        ! 引数
        !> array_size 走査する自然数の上限
        integer(int32), intent(in) :: array_size
        ! 戻り値
        !> インデックス i が素数なら true、そうでないなら false を格納する logical 配列
        logical, allocatable :: is_prime(:)
        ! 変数
        ! 実際に走査する自然数の最大値
        integer(int32) max_iteration
        ! ループ カウンタ
        integer(int32) i

        ! インデックス i が素数なら要素が true である論理型配列を初期化します。
        ! 2 を素数、2 より大きい偶数を非素数と判定します。
        is_prime = initialize_prime_number_flag(array_size)

        ! 3 から sqrt(array_size) までの奇数が素数であるか走査します。
        ! 素数 p の倍数を消去する時、p * 2 から p * (p - 1) は
        ! すでに消去されているので p * p から消去します。
        ! 従って、 sqrt(array_size) までループを回せば十分です。
        max_iteration = int(sqrt(dble(array_size)))
        do i = 3, max_iteration, 2
            ! すでに判定した整数はとばします。
            if (.not. is_prime(i)) cycle

            ! i^2 から array_size までの i の倍数を false にします。
            is_prime(i * i:array_size:i) = .false.
        end do
    end function
end module
