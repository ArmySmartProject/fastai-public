<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link rel="stylesheet" href="resources/css/jquery-ui.min.css"> -->
    <link rel="stylesheet" href="resources/css/ui.jqgrid.css">
    <title>Document</title>
</head>
<body>
<style type="text/css">

    /* set the size of the datepicker search control for Order Date*/
    #ui-datepicker-div { font-size:11px; }

    /* set the size of the autocomplete search control*/
    .ui-menu-item {
        font-size: 11px;
    }

    .ui-autocomplete {
        font-size: 11px;
    }
</style>

<table id="jqGrid"></table>
<div id="jqGridPager"></div>


<script src="${pageContext.request.contextPath}/resources/js/jquery-1.7.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.jqGrid.min.js"></script>
<!-- <script src="resources/js/jquery.jqGrid.src.js"></script> -->
<script type="text/javascript">

  $(document).ready(function () {
    var dataDetail = [
      {"OrderID":"10248","OrderDate":"1996-07-04","CustomerID":"WILMK","ShipName":"Vins et alcools Chevalier","Freight":"32.3800"},
      {"OrderID":"10249","OrderDate":"1996-07-05","CustomerID":"TRADH","ShipName":"Toms Spezialit\u00e4ten","Freight":"11.6100"},
      {"OrderID":"10250","OrderDate":"1996-07-08","CustomerID":"HANAR","ShipName":"Hanari Carnes","Freight":"65.8300"},
      {"OrderID":"10251","OrderDate":"1996-07-08","CustomerID":"VICTE","ShipName":"Victuailles en stock","Freight":"41.3400"},
      {"OrderID":"10252","OrderDate":"1996-07-09","CustomerID":"SUPRD","ShipName":"Supr\u00eames d\u00e9lices","Freight":"51.3000"},
      {"OrderID":"10253","OrderDate":"1996-07-10","CustomerID":"HANAR","ShipName":"Hanari Carnes","Freight":"58.1700"},
      {"OrderID":"10254","OrderDate":"1996-07-11","CustomerID":"CHOPS","ShipName":"Chop-suey Chinese","Freight":"22.9800"},
      {"OrderID":"10255","OrderDate":"1996-07-12","CustomerID":"RICSU","ShipName":"Richter Supermarkt","Freight":"148.3300"},
      {"OrderID":"10256","OrderDate":"1996-07-15","CustomerID":"WELLI","ShipName":"Wellington Importadora","Freight":"13.9700"},
      {"OrderID":"10257","OrderDate":"1996-07-16","CustomerID":"HILAA","ShipName":"HILARI\u00d3N-Abastos","Freight":"81.9100"},
      {"OrderID":"10258","OrderDate":"1996-07-17","CustomerID":"ERNSH","ShipName":"Ernst Handel","Freight":"140.5100"},
      {"OrderID":"10259","OrderDate":"1996-07-18","CustomerID":"CENTC","ShipName":"Centro comercial Moctezuma","Freight":"3.2500"},
      {"OrderID":"10260","OrderDate":"1996-07-19","CustomerID":"OLDWO","ShipName":"Ottilies K\u00e4seladen","Freight":"55.0900"},
      {"OrderID":"10261","OrderDate":"1996-07-19","CustomerID":"QUEDE","ShipName":"Que Del\u00edcia","Freight":"3.0500"},
      {"OrderID":"10262","OrderDate":"1996-07-22","CustomerID":"RATTC","ShipName":"Rattlesnake Canyon Grocery","Freight":"48.2900"},
      {"OrderID":"10263","OrderDate":"1996-07-23","CustomerID":"ERNSH","ShipName":"Ernst Handel","Freight":"146.0600"},
      {"OrderID":"10264","OrderDate":"1996-07-24","CustomerID":"FOLKO","ShipName":"Folk och f\u00e4 HB","Freight":"3.6700"},
      {"OrderID":"10265","OrderDate":"1996-07-25","CustomerID":"BLONP","ShipName":"Blondel p\u00e8re et fils","Freight":"55.2800"},
      {"OrderID":"10266","OrderDate":"1996-07-26","CustomerID":"WARTH","ShipName":"Wartian Herkku","Freight":"25.7300"},
      {"OrderID":"10267","OrderDate":"1996-07-29","CustomerID":"FRANK","ShipName":"Frankenversand","Freight":"208.5800"},
      {"OrderID":"10268","OrderDate":"1996-07-30","CustomerID":"GROSR","ShipName":"GROSELLA-Restaurante","Freight":"66.2900"},
      {"OrderID":"10269","OrderDate":"1996-07-31","CustomerID":"WHITC","ShipName":"White Clover Markets","Freight":"4.5600"},
      {"OrderID":"10270","OrderDate":"1996-08-01","CustomerID":"WARTH","ShipName":"Wartian Herkku","Freight":"136.5400"},
      {"OrderID":"10271","OrderDate":"1996-08-01","CustomerID":"SPLIR","ShipName":"Split Rail Beer & Ale","Freight":"4.5400"},
      {"OrderID":"10272","OrderDate":"1996-08-02","CustomerID":"RATTC","ShipName":"Rattlesnake Canyon Grocery","Freight":"98.0300"},
      {"OrderID":"10273","OrderDate":"1996-08-05","CustomerID":"QUICK","ShipName":"QUICK-Stop","Freight":"76.0700"},
      {"OrderID":"10274","OrderDate":"1996-08-06","CustomerID":"VINET","ShipName":"Vins et alcools Chevalier","Freight":"6.0100"},
      {"OrderID":"10275","OrderDate":"1996-08-07","CustomerID":"MAGAA","ShipName":"Magazzini Alimentari Riuniti","Freight":"26.9300"}
    ]


    $("#jqGrid").jqGrid({
      search: true,
      data: dataDetail,
      datatype: "local",
      page: 1,
      autowidth: true, // 가로 100% 설정 기능
      height: 'auto',
      autoResizing: true,
      rowNum: 30,
      rowList: [10,20,30],
      colModel: [
        {
          label: "Order ID",
          name: 'OrderID',
          key: true,
          width: 75,
          searchoptions: { sopt: ["eq"] }
        },
        {
          label: "Customer ID",
          name: 'CustomerID',
          editable: true,
          width: 150,
          edittype: 'select',
          editoptions: { value: ":[All];ALFKI:ALFKI;ANATR:ANATR;ANTON:ANTON;AROUT:AROUT;BERGS:BERGS;BLAUS:BLAUS;BLONP:BLONP;BOLID:BOLID;BONAP:BONAP;BOTTM:BOTTM;BSBEV:BSBEV;CACTU:CACTU;CENTC:CENTC;CHOPS:CHOPS;COMMI:COMMI;CONSH:CONSH;DRACD:DRACD;DUMON:DUMON;EASTC:EASTC;ERNSH:ERNSH;FAMIA:FAMIA;FOLIG:FOLIG;FOLKO:FOLKO;FRANK:FRANK;FRANR:FRANR;FRANS:FRANS;FURIB:FURIB;GALED:GALED;GODOS:GODOS;GOURL:GOURL;GREAL:GREAL;GROSR:GROSR;HANAR:HANAR;HILAA:HILAA;HUNGC:HUNGC;HUNGO:HUNGO;ISLAT:ISLAT;KOENE:KOENE;LACOR:LACOR;LAMAI:LAMAI;LAUGB:LAUGB;LAZYK:LAZYK;LEHMS:LEHMS;LETSS:LETSS;LILAS:LILAS;LINOD:LINOD;LONEP:LONEP;MAGAA:MAGAA;MAISD:MAISD;MEREP:MEREP;MORGK:MORGK;NORTS:NORTS;OCEAN:OCEAN;OLDWO:OLDWO;OTTIK:OTTIK;PERIC:PERIC;PICCO:PICCO;PRINI:PRINI;QUEDE:QUEDE;QUEEN:QUEEN;QUICK:QUICK;RANCH:RANCH;RATTC:RATTC;REGGC:REGGC;RICAR:RICAR;RICSU:RICSU;ROMEY:ROMEY;SANTG:SANTG;SAVEA:SAVEA;SEVES:SEVES;SIMOB:SIMOB;SPECD:SPECD;SPLIR:SPLIR;SUPRD:SUPRD;THEBI:THEBI;THECR:THECR;TOMSP:TOMSP;TORTU:TORTU;TRADH:TRADH;TRAIH:TRAIH;VAFFE:VAFFE;VICTE:VICTE;VINET:VINET;WANDK:WANDK;WARTH:WARTH;WELLI:WELLI;WHITC:WHITC;WILMK:WILMK;WOLZA:WOLZA" },
          stype: "select"
        },
      ],
      customFilterDef: {
        tst: {
          "operand": "=<",
          "text": "My less text",
          action: function (op) {
            console.log(this.op);
            return parseFloat(op.searchValue) >= parseFloat(op.rowItem.Freight);
          }
        }
      },
    });
    // activate the toolbar searching
    $('#jqGrid').jqGrid('filterToolbar', { restoreFromFilters: true, searchOperators: true });
    $('#jqGrid').jqGrid('navGrid', "#jqGridPager", {
      search: true, // show search button on the toolbar
      add: true,
      edit: true,
      del: true,
      refresh: true
    }, {}, {}, {}, { showQuery: true, multipleSearch: false });
  });

</script>
</body>
</html>