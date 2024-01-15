#!/bin/bash
UML_NAME=$1
PAGE_PATH=$2
PUML_PATH="${PAGE_PATH}/diagrams/${UML_NAME}.puml"
SVG_PATH="${PAGE_PATH}/images/"
TEMP_PATH='./temp'
PLANTUML_PATH='/Library/Java/Extensions/plantuml-1.2023.1.jar'

# Проверяем PlantUML в системе
if ! test -f $PLANTUML_PATH; then
  echo "PlantUML jar-file not found.\nPlease download the file at https://plantuml.com/ru/download\nand then save it as /Library/Java/Extensions/plantuml-1.2023.1.jar"
  exit 1
fi

# Добавляем в диаграмму темную тему
head -n 1 $PUML_PATH > $TEMP_PATH
echo "!include ./resourses/dark-theme.puml" >> $TEMP_PATH
tail -n +2 $PUML_PATH >> $TEMP_PATH

# Генерируем диаграмму с темной темой
java -jar $PLANTUML_PATH -svg $TEMP_PATH -o $SVG_PATH

# Удаляем временный файл
rm $TEMP_PATH

# plantuml генерирует имя файла на основе имени диаграммы. Переименовываем файл
mv "${SVG_PATH}/${UML_NAME}.svg" "${SVG_PATH}/${UML_NAME}-dark.svg"

# Добавляем в диаграмму светлую тему
head -n 1 $PUML_PATH > $TEMP_PATH
echo "!include ./resourses/light-theme.puml" >> $TEMP_PATH
tail -n +2 $PUML_PATH >> $TEMP_PATH

# Генерируем диаграмму со светлой темой
java -jar $PLANTUML_PATH -svg $TEMP_PATH -o $SVG_PATH

# Удаляем временный файл
rm $TEMP_PATH

