[#macro printOperationalTableColumn column]
  [#if (column.type)! == "DATETIME"]
    [=(column.value?datetime.iso?string('dd.MM.yyyy HH:mm:ss'))!]
  [#elseif (column.type)! == "DATE"]
    [=(column.value?date.iso?string('dd.MM.yyyy'))!]
  [#elseif (column.type)! == "TIME"]
    [=(column.value?time.iso?string('HH:mm:ss'))!]
  [#else]
    [=(column.value)!]
  [/#if]
[/#macro]

[#assign operationMap = { "I": "Створення", "U": "Зміна", "D": "Видалення" }]

<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="center">
  <img src="images/ua.png" class="ua-img" />
</div>

<h1 class="header">Історія змін даних</h1>
<h3 class="header"><b>Таблиця:</b> [=tableName]</h3>
<h3 class="header"><b>Запис:</b> [=entityId]</h3>
[#assign currentPrintIndex=0]
[#list 0.. as _]
  [#if currentPrintIndex >= data.excerptRows?size]
    [#break]
  [/#if]
  <table>
    <tr class="table-header">
      <th>Поля</th>
      <th colspan="3">Зміни</th>
    </tr>
    <tr>
      <th>Час створення</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].ddmInfo.createdAt?datetime.iso?string('dd.MM.yyyy HH:mm:ss'))!]</td>
      [/#list]
    </tr>
    [#list data.operationalTableFields as field]
    <tr>
      <th>[=field]</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[@printOperationalTableColumn column=(data.excerptRows[i].operationalTableData[field])! /]</td>
      [/#list]
    </tr>
    [/#list]
    <tr class="sysinfo-row">
      <th>Автор</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].ddmInfo.createdBy)!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>Код операції</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(operationMap[(data.excerptRows[i].ddmInfo.dmlOp)!])!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>Ім'я системи</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].ddmInfo.system)!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>Ім'я додатку</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].ddmInfo.application)!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>Ідентифікатор бізнес процесу</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].ddmInfo.businessProcessId)!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>Назва кроку в бізнес процесі</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].ddmInfo.businessActivity)!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>Ім'я підписанта</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].userInfo.fullName)!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>ДРФО підписанта</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].userInfo.drfo)!]</td>
      [/#list]
    </tr>
    <tr class="sysinfo-row">
      <th>ЄДРПОУ підписанта</th>
      [#list currentPrintIndex..currentPrintIndex+2 as i]
        <td>[=(data.excerptRows[i].userInfo.edrpou)!]</td>
      [/#list]
    </tr>
  </table>
[#assign currentPrintIndex += 3]
[/#list]
</body>
</html>
