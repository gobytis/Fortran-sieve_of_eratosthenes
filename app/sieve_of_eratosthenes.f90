!| エラトステネスのふるいを用いて、
!  指定の自然数以下の素数を調べるプログラムです。
!
! コマンド ライン引数で自然数のみを指定すると、
! 指定した自然数以下の素数とその個数を標準出力に表示します。
! 
! コマンド ライン引数で自然数とファイル名を指定すると、
! 指定した自然数以下の素数を、指定のファイルに出力します。
program main_program
    use, intrinsic :: iso_fortran_env
    use class_argument_getter
    use class_sieve_of_eratosthenes
    implicit none

    !> 走査する自然数の上限 
    integer upper_limit
    !> 出力ファイル名
    character(:), allocatable :: output_file_name
    !> コマンド ライン引数取得のためのクラス
    type(argument_getter) args_getter
    !> エラトステネスのふるいを実行するクラス
    type(sieve_of_eratosthenes) sieve
    !> 素数を格納する配列
    integer(int32), allocatable :: prime_numbers(:)


    ! コマンド ライン引数が不正であれば終了します。
    if (args_getter%get_size() == 0 .or. args_getter%get_size() > 2) then
        write(error_unit, *) "ERROR:"
        write(error_unit, *) "The command line arguments are followings:"
        write(error_unit, *) " - positive_integer: integer"
        write(error_unit, *) " - output_file_name [optional]: character"
        write(error_unit, *) ""
        write(error_unit, *) "(e.g.1) sieve_of_eratosthenes.exe 100"
        write(error_unit, *) " => Prime Numbers are written in standard output."
        write(error_unit, *) ""
        write(error_unit, *) "(e.g.2) sieve_of_eratosthenes.exe 100 prime_numbers.txt"
        write(error_unit, *) " => Prime Numbers are written in 'prime_numbers.txt'."
        write(error_unit, *) ""
        write(error_unit, *) "Program ended."
        stop
    end if

    ! 指定された自然数が 0 以下であれば、エラーを表示して終了します。
    if (args_getter%to_int32(1) <= 0) then
        write(error_unit, *) "ERROR : The first argument must be a positive integer."
        write(error_unit, *) "Program ended."
        stop
    end if

    ! 出力ファイル名が指定されている場合
    if (args_getter%get_size() == 2) then
        ! 出力ファイル名を決定します。
        output_file_name = args_getter%get(2)
    else
        ! 出力ファイル名は空にします。
        output_file_name = ""
    end if

    ! コマンド ライン引数から走査する自然数の上限を決定します。
    upper_limit = args_getter%to_int32(1)

    ! エラトステネスのふるいを実行し、素数を格納した配列を取得します。
    prime_numbers = sieve%sieve(upper_limit)

    if (output_file_name == "") then
        ! 出力ファイル名の指定がない場合
        ! 素数の個数と素数の一覧を標準出力に表示します。
        call show_prime_numbers(prime_numbers)
    else
        ! 出力ファイル名が指定されている場合
        ! 素数を指定の名前の出力ファイルに出力します。
        call write_prime_numbers(prime_numbers, output_file_name)
    end if


    contains


    !> 与えられた整数配列の個数と要素を標準出力に表示します。
    subroutine show_prime_numbers(prime_numbers)
        ! 引数
        !> 表示する整数配列
        integer(int32), intent(in) :: prime_numbers(:)
        ! 素数の個数
        integer(int32) number_of_primes

        ! ループ カウンタ
        integer(int32) i

        ! 素数の個数を取得します。
        number_of_primes = size(prime_numbers)

        ! 素数の個数が 0 個の時は終了します。
        if (number_of_primes == 0) return

        ! 素数を標準出力に列挙します。
        print*, "Prime numbers are followings:"
        do i = 1, size(prime_numbers)
            print*, prime_numbers(i)
        end do

        ! 素数の個数を表示します。
        print'(A, I0)', "The number of primes is ", number_of_primes
    end subroutine


    !> 指定の整数配列を指定のファイルに出力します。
    subroutine write_prime_numbers(prime_numbers, output_file_name)
        ! 引数
        !> 出力する整数配列
        integer(int32), intent(in) :: prime_numbers(:)
        !> 出力ファイル名
        character(*), intent(in) :: output_file_name
        ! 装置番号
        integer(int32) output_file_unit
        ! ループ カウンタ
        integer(int32) i

        open(newunit=output_file_unit, file=output_file_name, status="replace")

        if (size(prime_numbers) == 0) then
            ! 素数の個数が 0 個の時は終了します。
            return
        else
            ! 素数を出力ファイルに書き出します。
            do i = 1, size(prime_numbers)
                write(output_file_unit, *) prime_numbers(i)
            end do
        end if

        close(output_file_unit)
    end subroutine

end program
