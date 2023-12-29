#!/bin/bash
#answer1=4
#while [[ $answer1 -eq 4 ]];
#do
  #if dpkg-query -W -f='${Status}' "xinput-calibrator" 2>/dev/null | grep -q "ok installed"; then
      # xinput установлен
  ##Чтение
   printf "Что нужно сделать?
   1-Повернуть сенсор
   2-Откалибровать сенсор
   3-Обновить пакеты
   4-Выйти из программы\n"
   read answer1
  if [ "$answer1" == "1" ]; then
  #Поворот сенсора
    apt-get update && apt-get install xinput -y
    xinput list
    printf "Введите id калибруемого устройства\n"
    read id1
    printf "Введите угол поворота: 90, 180 или 270\n"
    read angle1
    if [ "$angle1" == "90" ]; then
      xinput set-prop $id1 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
    elif [ "$angle1" == "180" ]; then
      xinput set-prop $id1 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
    elif [ "$angle1" == "270" ]; then
      xinput set-prop $id1 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
  elif [ "$answer1" == "2" ]; then
  #Калибровка сенсора
    if dpkg-query -W -f='${Status}' "xinput-calibrator" 2>/dev/null | grep -q "ok installed"; then
    # xinput установлен
    xinput_calibrator
    else
        # xinput не установлен
        echo "Установка пакетов"
        apt-get update && apt-get install xinput -y && apt-get install xinput-calibrator -y
        xinput_calibrator
      fi
  elif [ "$answer1" == "3" ]; then
  ##Обновление xinput
  apt-get update && apt-get install xinput -y && apt-get install xinput-calibrator -y
  elif [ "$answer1" == "4" ]; then
  exit
  else
   #Ошибка ввода
    echo "Неверное значение!"
    exit
done
