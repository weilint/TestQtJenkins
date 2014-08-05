import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1
import "../share"

import StudyListLibrary 1.0
import StudyObjectLibrary 1.0
import EditInfoLibrary 1.0
import SeriesLisLibrary 1.0
import ImageListLibrary 1.0

Rectangle {
    id: root
    anchors.fill: parent
    //color:  "#303030"
    //color:"royalblue"

    property int numOfSerieses: richListCurrentStudy.numOfSerieses
    property int currentSeriesIndex: 0
    //property int numOfImages: 0
    //signal clicked(int index)

    ListModel {
    id: model01
    ListElement {imageSource: "file:///C:/Array/GrandBleu_AppData/Data/Thumbnails/20130117/00_2013011721534360002082466.jpg"}
    ListElement {imageSource: "../data/01/00019767.jpg"}
    ListElement {imageSource: "../data/01/00019768.jpg"}
    ListElement {imageSource: "../data/01/00019769.jpg"}
    ListElement {imageSource: "../data/01/00019770.jpg"}
    ListElement {imageSource: "../data/01/00019771.jpg"}
    ListElement {imageSource: "../data/01/00019772.jpg"}
    ListElement {imageSource: "../data/01/00019773.jpg"}
    ListElement {imageSource: "../data/01/00019774.jpg"}
    ListElement {imageSource: "../data/01/00019775.jpg"}
    ListElement {imageSource: "../data/01/00019776.jpg"}
    ListElement {imageSource: "../data/01/00019777.jpg"}
    ListElement {imageSource: "../data/01/00019778.jpg"}
    }


    ListModel {
    id: model02
    ListElement {imageSource: "../data/02/00019779.jpg"}
    ListElement {imageSource: "../data/02/00019780.jpg"}
    ListElement {imageSource: "../data/02/00019781.jpg"}
    ListElement {imageSource: "../data/02/00019782.jpg"}
    ListElement {imageSource: "../data/02/00019783.jpg"}
    ListElement {imageSource: "../data/02/00019784.jpg"}
    ListElement {imageSource: "../data/02/00019785.jpg"}
    ListElement {imageSource: "../data/02/00019786.jpg"}
    ListElement {imageSource: "../data/02/00019787.jpg"}
    ListElement {imageSource: "../data/02/00019788.jpg"}
    ListElement {imageSource: "../data/02/00019789.jpg"}
    ListElement {imageSource: "../data/02/00019790.jpg"}
    ListElement {imageSource: "../data/02/00019791.jpg"}
    ListElement {imageSource: "../data/02/00019792.jpg"}
    ListElement {imageSource: "../data/02/00019793.jpg"}
    ListElement {imageSource: "../data/02/00019794.jpg"}
    ListElement {imageSource: "../data/02/00019795.jpg"}
    ListElement {imageSource: "../data/02/00019796.jpg"}
    ListElement {imageSource: "../data/02/00019797.jpg"}
    ListElement {imageSource: "../data/02/00019798.jpg"}
    ListElement {imageSource: "../data/02/00019799.jpg"}
    ListElement {imageSource: "../data/02/00019800.jpg"}
    ListElement {imageSource: "../data/02/00019801.jpg"}
    ListElement {imageSource: "../data/02/00019802.jpg"}
    ListElement {imageSource: "../data/02/00019803.jpg"}
    ListElement {imageSource: "../data/02/00019804.jpg"}
    ListElement {imageSource: "../data/02/00019805.jpg"}
    ListElement {imageSource: "../data/02/00019806.jpg"}
    ListElement {imageSource: "../data/02/00019807.jpg"}
    ListElement {imageSource: "../data/02/00019808.jpg"}
    ListElement {imageSource: "../data/02/00019809.jpg"}
    ListElement {imageSource: "../data/02/00019810.jpg"}
    ListElement {imageSource: "../data/02/00019811.jpg"}
    ListElement {imageSource: "../data/02/00019812.jpg"}
    ListElement {imageSource: "../data/02/00019813.jpg"}
    ListElement {imageSource: "../data/02/00019814.jpg"}
    ListElement {imageSource: "../data/02/00019815.jpg"}
    ListElement {imageSource: "../data/02/00019816.jpg"}
    ListElement {imageSource: "../data/02/00019817.jpg"}
    ListElement {imageSource: "../data/02/00019818.jpg"}
    ListElement {imageSource: "../data/02/00019819.jpg"}
    ListElement {imageSource: "../data/02/00019820.jpg"}
    ListElement {imageSource: "../data/02/00019821.jpg"}
    ListElement {imageSource: "../data/02/00019822.jpg"}
    ListElement {imageSource: "../data/02/00019823.jpg"}
    ListElement {imageSource: "../data/02/00019824.jpg"}
    }


    ListModel {
    id: model03
    ListElement {imageSource: "../data/03/00019825.jpg"}
    ListElement {imageSource: "../data/03/00019826.jpg"}
    ListElement {imageSource: "../data/03/00019827.jpg"}
    ListElement {imageSource: "../data/03/00019828.jpg"}
    ListElement {imageSource: "../data/03/00019829.jpg"}
    ListElement {imageSource: "../data/03/00019830.jpg"}
    ListElement {imageSource: "../data/03/00019831.jpg"}
    ListElement {imageSource: "../data/03/00019832.jpg"}
    ListElement {imageSource: "../data/03/00019833.jpg"}
    ListElement {imageSource: "../data/03/00019834.jpg"}
    ListElement {imageSource: "../data/03/00019835.jpg"}
    ListElement {imageSource: "../data/03/00019836.jpg"}
    ListElement {imageSource: "../data/03/00019837.jpg"}
    ListElement {imageSource: "../data/03/00019838.jpg"}
    ListElement {imageSource: "../data/03/00019839.jpg"}
    ListElement {imageSource: "../data/03/00019840.jpg"}
    ListElement {imageSource: "../data/03/00019841.jpg"}
    ListElement {imageSource: "../data/03/00019842.jpg"}
    ListElement {imageSource: "../data/03/00019843.jpg"}
    ListElement {imageSource: "../data/03/00019844.jpg"}
    ListElement {imageSource: "../data/03/00019845.jpg"}
    ListElement {imageSource: "../data/03/00019846.jpg"}
    ListElement {imageSource: "../data/03/00019847.jpg"}
    ListElement {imageSource: "../data/03/00019848.jpg"}
    ListElement {imageSource: "../data/03/00019849.jpg"}
    ListElement {imageSource: "../data/03/00019850.jpg"}
    ListElement {imageSource: "../data/03/00019851.jpg"}
    ListElement {imageSource: "../data/03/00019852.jpg"}
    ListElement {imageSource: "../data/03/00019853.jpg"}
    ListElement {imageSource: "../data/03/00019854.jpg"}
    ListElement {imageSource: "../data/03/00019855.jpg"}
    ListElement {imageSource: "../data/03/00019856.jpg"}
    ListElement {imageSource: "../data/03/00019857.jpg"}
    ListElement {imageSource: "../data/03/00019858.jpg"}
    ListElement {imageSource: "../data/03/00019859.jpg"}
    ListElement {imageSource: "../data/03/00019860.jpg"}
    ListElement {imageSource: "../data/03/00019861.jpg"}
    ListElement {imageSource: "../data/03/00019862.jpg"}
    ListElement {imageSource: "../data/03/00019863.jpg"}
    ListElement {imageSource: "../data/03/00019864.jpg"}
    ListElement {imageSource: "../data/03/00019865.jpg"}
    ListElement {imageSource: "../data/03/00019866.jpg"}
    ListElement {imageSource: "../data/03/00019867.jpg"}
    ListElement {imageSource: "../data/03/00019868.jpg"}
    ListElement {imageSource: "../data/03/00019869.jpg"}
    ListElement {imageSource: "../data/03/00019870.jpg"}
    ListElement {imageSource: "../data/03/00019871.jpg"}
    ListElement {imageSource: "../data/03/00019872.jpg"}
    ListElement {imageSource: "../data/03/00019873.jpg"}
    ListElement {imageSource: "../data/03/00019874.jpg"}
    ListElement {imageSource: "../data/03/00019875.jpg"}
    ListElement {imageSource: "../data/03/00019876.jpg"}
    ListElement {imageSource: "../data/03/00019877.jpg"}
    ListElement {imageSource: "../data/03/00019878.jpg"}
    ListElement {imageSource: "../data/03/00019879.jpg"}
    ListElement {imageSource: "../data/03/00019880.jpg"}
    ListElement {imageSource: "../data/03/00019881.jpg"}
    ListElement {imageSource: "../data/03/00019882.jpg"}
    ListElement {imageSource: "../data/03/00019883.jpg"}
    ListElement {imageSource: "../data/03/00019884.jpg"}
    ListElement {imageSource: "../data/03/00019885.jpg"}
    ListElement {imageSource: "../data/03/00019886.jpg"}
    ListElement {imageSource: "../data/03/00019887.jpg"}
    ListElement {imageSource: "../data/03/00019888.jpg"}
    ListElement {imageSource: "../data/03/00019889.jpg"}
    ListElement {imageSource: "../data/03/00019890.jpg"}
    }


    ListModel {
    id: model04
    ListElement {imageSource: "../data/04/00019891.jpg"}
    ListElement {imageSource: "../data/04/00019892.jpg"}
    ListElement {imageSource: "../data/04/00019893.jpg"}
    ListElement {imageSource: "../data/04/00019894.jpg"}
    ListElement {imageSource: "../data/04/00019895.jpg"}
    ListElement {imageSource: "../data/04/00019896.jpg"}
    ListElement {imageSource: "../data/04/00019897.jpg"}
    ListElement {imageSource: "../data/04/00019898.jpg"}
    ListElement {imageSource: "../data/04/00019899.jpg"}
    ListElement {imageSource: "../data/04/00019900.jpg"}
    ListElement {imageSource: "../data/04/00019901.jpg"}
    ListElement {imageSource: "../data/04/00019902.jpg"}
    ListElement {imageSource: "../data/04/00019903.jpg"}
    ListElement {imageSource: "../data/04/00019904.jpg"}
    ListElement {imageSource: "../data/04/00019905.jpg"}
    ListElement {imageSource: "../data/04/00019906.jpg"}
    ListElement {imageSource: "../data/04/00019907.jpg"}
    ListElement {imageSource: "../data/04/00019908.jpg"}
    ListElement {imageSource: "../data/04/00019909.jpg"}
    ListElement {imageSource: "../data/04/00019910.jpg"}
    ListElement {imageSource: "../data/04/00019911.jpg"}
    ListElement {imageSource: "../data/04/00019912.jpg"}
    ListElement {imageSource: "../data/04/00019913.jpg"}
    ListElement {imageSource: "../data/04/00019914.jpg"}
    ListElement {imageSource: "../data/04/00019915.jpg"}
    ListElement {imageSource: "../data/04/00019916.jpg"}
    ListElement {imageSource: "../data/04/00019917.jpg"}
    ListElement {imageSource: "../data/04/00019918.jpg"}
    ListElement {imageSource: "../data/04/00019919.jpg"}
    ListElement {imageSource: "../data/04/00019920.jpg"}
    ListElement {imageSource: "../data/04/00019921.jpg"}
    ListElement {imageSource: "../data/04/00019922.jpg"}
    ListElement {imageSource: "../data/04/00019923.jpg"}
    ListElement {imageSource: "../data/04/00019924.jpg"}
    ListElement {imageSource: "../data/04/00019925.jpg"}
    ListElement {imageSource: "../data/04/00019926.jpg"}
    ListElement {imageSource: "../data/04/00019927.jpg"}
    ListElement {imageSource: "../data/04/00019928.jpg"}
    ListElement {imageSource: "../data/04/00019929.jpg"}
    ListElement {imageSource: "../data/04/00019930.jpg"}
    ListElement {imageSource: "../data/04/00019931.jpg"}
    ListElement {imageSource: "../data/04/00019932.jpg"}
    ListElement {imageSource: "../data/04/00019933.jpg"}
    ListElement {imageSource: "../data/04/00019934.jpg"}
    ListElement {imageSource: "../data/04/00019935.jpg"}
    ListElement {imageSource: "../data/04/00019936.jpg"}
    ListElement {imageSource: "../data/04/00019937.jpg"}
    ListElement {imageSource: "../data/04/00019938.jpg"}
    ListElement {imageSource: "../data/04/00019939.jpg"}
    ListElement {imageSource: "../data/04/00019940.jpg"}
    ListElement {imageSource: "../data/04/00019941.jpg"}
    ListElement {imageSource: "../data/04/00019942.jpg"}
    ListElement {imageSource: "../data/04/00019943.jpg"}
    ListElement {imageSource: "../data/04/00019944.jpg"}
    ListElement {imageSource: "../data/04/00019945.jpg"}
    ListElement {imageSource: "../data/04/00019946.jpg"}
    ListElement {imageSource: "../data/04/00019947.jpg"}
    ListElement {imageSource: "../data/04/00019948.jpg"}
    ListElement {imageSource: "../data/04/00019949.jpg"}
    ListElement {imageSource: "../data/04/00019950.jpg"}
    ListElement {imageSource: "../data/04/00019951.jpg"}
    ListElement {imageSource: "../data/04/00019952.jpg"}
    ListElement {imageSource: "../data/04/00019953.jpg"}
    ListElement {imageSource: "../data/04/00019954.jpg"}
    ListElement {imageSource: "../data/04/00019955.jpg"}
    ListElement {imageSource: "../data/04/00019956.jpg"}
    ListElement {imageSource: "../data/04/00019957.jpg"}
    ListElement {imageSource: "../data/04/00019958.jpg"}
    ListElement {imageSource: "../data/04/00019959.jpg"}
    ListElement {imageSource: "../data/04/00019960.jpg"}
    ListElement {imageSource: "../data/04/00019961.jpg"}
    ListElement {imageSource: "../data/04/00019962.jpg"}
    ListElement {imageSource: "../data/04/00019963.jpg"}
    ListElement {imageSource: "../data/04/00019964.jpg"}
    ListElement {imageSource: "../data/04/00019965.jpg"}
    ListElement {imageSource: "../data/04/00019966.jpg"}
    ListElement {imageSource: "../data/04/00019967.jpg"}
    ListElement {imageSource: "../data/04/00019968.jpg"}
    }


    ListModel {
    id: model05
    ListElement {imageSource: "../data/05/00019969.jpg"}
    ListElement {imageSource: "../data/05/00019970.jpg"}
    ListElement {imageSource: "../data/05/00019971.jpg"}
    ListElement {imageSource: "../data/05/00019972.jpg"}
    ListElement {imageSource: "../data/05/00019973.jpg"}
    ListElement {imageSource: "../data/05/00019974.jpg"}
    ListElement {imageSource: "../data/05/00019975.jpg"}
    ListElement {imageSource: "../data/05/00019976.jpg"}
    ListElement {imageSource: "../data/05/00019977.jpg"}
    ListElement {imageSource: "../data/05/00019978.jpg"}
    ListElement {imageSource: "../data/05/00019979.jpg"}
    ListElement {imageSource: "../data/05/00019980.jpg"}
    ListElement {imageSource: "../data/05/00019981.jpg"}
    ListElement {imageSource: "../data/05/00019982.jpg"}
    ListElement {imageSource: "../data/05/00019983.jpg"}
    ListElement {imageSource: "../data/05/00019984.jpg"}
    ListElement {imageSource: "../data/05/00019985.jpg"}
    ListElement {imageSource: "../data/05/00019986.jpg"}
    ListElement {imageSource: "../data/05/00019987.jpg"}
    ListElement {imageSource: "../data/05/00019988.jpg"}
    ListElement {imageSource: "../data/05/00019989.jpg"}
    ListElement {imageSource: "../data/05/00019990.jpg"}
    ListElement {imageSource: "../data/05/00019991.jpg"}
    ListElement {imageSource: "../data/05/00019992.jpg"}
    ListElement {imageSource: "../data/05/00019993.jpg"}
    ListElement {imageSource: "../data/05/00019994.jpg"}
    ListElement {imageSource: "../data/05/00019995.jpg"}
    ListElement {imageSource: "../data/05/00019996.jpg"}
    ListElement {imageSource: "../data/05/00019997.jpg"}
    ListElement {imageSource: "../data/05/00019998.jpg"}
    ListElement {imageSource: "../data/05/00019999.jpg"}
    ListElement {imageSource: "../data/05/00020000.jpg"}
    ListElement {imageSource: "../data/05/00020001.jpg"}
    ListElement {imageSource: "../data/05/00020002.jpg"}
    ListElement {imageSource: "../data/05/00020003.jpg"}
    ListElement {imageSource: "../data/05/00020004.jpg"}
    ListElement {imageSource: "../data/05/00020005.jpg"}
    ListElement {imageSource: "../data/05/00020006.jpg"}
    ListElement {imageSource: "../data/05/00020007.jpg"}
    ListElement {imageSource: "../data/05/00020008.jpg"}
    ListElement {imageSource: "../data/05/00020009.jpg"}
    ListElement {imageSource: "../data/05/00020010.jpg"}
    ListElement {imageSource: "../data/05/00020011.jpg"}
    ListElement {imageSource: "../data/05/00020012.jpg"}
    ListElement {imageSource: "../data/05/00020013.jpg"}
    ListElement {imageSource: "../data/05/00020014.jpg"}
    ListElement {imageSource: "../data/05/00020015.jpg"}
    ListElement {imageSource: "../data/05/00020016.jpg"}
    }


    ListModel {
    id: model06
    ListElement {imageSource: "../data/06/00020017.jpg"}
    ListElement {imageSource: "../data/06/00020018.jpg"}
    ListElement {imageSource: "../data/06/00020019.jpg"}
    ListElement {imageSource: "../data/06/00020020.jpg"}
    ListElement {imageSource: "../data/06/00020021.jpg"}
    ListElement {imageSource: "../data/06/00020022.jpg"}
    ListElement {imageSource: "../data/06/00020023.jpg"}
    ListElement {imageSource: "../data/06/00020024.jpg"}
    ListElement {imageSource: "../data/06/00020025.jpg"}
    ListElement {imageSource: "../data/06/00020026.jpg"}
    ListElement {imageSource: "../data/06/00020027.jpg"}
    ListElement {imageSource: "../data/06/00020028.jpg"}
    ListElement {imageSource: "../data/06/00020029.jpg"}
    ListElement {imageSource: "../data/06/00020030.jpg"}
    ListElement {imageSource: "../data/06/00020031.jpg"}
    ListElement {imageSource: "../data/06/00020032.jpg"}
    ListElement {imageSource: "../data/06/00020033.jpg"}
    ListElement {imageSource: "../data/06/00020034.jpg"}
    ListElement {imageSource: "../data/06/00020035.jpg"}
    ListElement {imageSource: "../data/06/00020036.jpg"}
    }


    ListModel {
    id: model07
    ListElement {imageSource: "../data/07/00020037.jpg"}
    ListElement {imageSource: "../data/07/00020038.jpg"}
    ListElement {imageSource: "../data/07/00020039.jpg"}
    ListElement {imageSource: "../data/07/00020040.jpg"}
    ListElement {imageSource: "../data/07/00020041.jpg"}
    ListElement {imageSource: "../data/07/00020042.jpg"}
    ListElement {imageSource: "../data/07/00020043.jpg"}
    }


    ListModel {
    id: model08
    ListElement {imageSource: "../data/08/00020044.jpg"}
    ListElement {imageSource: "../data/08/00020045.jpg"}
    ListElement {imageSource: "../data/08/00020046.jpg"}
    ListElement {imageSource: "../data/08/00020047.jpg"}
    ListElement {imageSource: "../data/08/00020048.jpg"}
    ListElement {imageSource: "../data/08/00020049.jpg"}
    ListElement {imageSource: "../data/08/00020050.jpg"}
    ListElement {imageSource: "../data/08/00020051.jpg"}
    ListElement {imageSource: "../data/08/00020052.jpg"}
    ListElement {imageSource: "../data/08/00020053.jpg"}
    ListElement {imageSource: "../data/08/00020054.jpg"}
    ListElement {imageSource: "../data/08/00020055.jpg"}
    ListElement {imageSource: "../data/08/00020056.jpg"}
    ListElement {imageSource: "../data/08/00020057.jpg"}
    ListElement {imageSource: "../data/08/00020058.jpg"}
    ListElement {imageSource: "../data/08/00020059.jpg"}
    ListElement {imageSource: "../data/08/00020060.jpg"}
    ListElement {imageSource: "../data/08/00020061.jpg"}
    ListElement {imageSource: "../data/08/00020062.jpg"}
    ListElement {imageSource: "../data/08/00020063.jpg"}
    ListElement {imageSource: "../data/08/00020064.jpg"}
    ListElement {imageSource: "../data/08/00020065.jpg"}
    ListElement {imageSource: "../data/08/00020066.jpg"}
    ListElement {imageSource: "../data/08/00020067.jpg"}
    ListElement {imageSource: "../data/08/00020068.jpg"}
    ListElement {imageSource: "../data/08/00020069.jpg"}
    ListElement {imageSource: "../data/08/00020070.jpg"}
    ListElement {imageSource: "../data/08/00020071.jpg"}
    ListElement {imageSource: "../data/08/00020072.jpg"}
    ListElement {imageSource: "../data/08/00020073.jpg"}
    ListElement {imageSource: "../data/08/00020074.jpg"}
    ListElement {imageSource: "../data/08/00020075.jpg"}
    ListElement {imageSource: "../data/08/00020076.jpg"}
    ListElement {imageSource: "../data/08/00020077.jpg"}
    ListElement {imageSource: "../data/08/00020078.jpg"}
    ListElement {imageSource: "../data/08/00020079.jpg"}
    ListElement {imageSource: "../data/08/00020080.jpg"}
    ListElement {imageSource: "../data/08/00020081.jpg"}
    ListElement {imageSource: "../data/08/00020082.jpg"}
    ListElement {imageSource: "../data/08/00020083.jpg"}
    ListElement {imageSource: "../data/08/00020084.jpg"}
    ListElement {imageSource: "../data/08/00020085.jpg"}
    ListElement {imageSource: "../data/08/00020086.jpg"}
    ListElement {imageSource: "../data/08/00020087.jpg"}
    ListElement {imageSource: "../data/08/00020088.jpg"}
    ListElement {imageSource: "../data/08/00020089.jpg"}
    ListElement {imageSource: "../data/08/00020090.jpg"}
    ListElement {imageSource: "../data/08/00020091.jpg"}
    ListElement {imageSource: "../data/08/00020092.jpg"}
    ListElement {imageSource: "../data/08/00020093.jpg"}
    ListElement {imageSource: "../data/08/00020094.jpg"}
    ListElement {imageSource: "../data/08/00020095.jpg"}
    ListElement {imageSource: "../data/08/00020096.jpg"}
    ListElement {imageSource: "../data/08/00020097.jpg"}
    ListElement {imageSource: "../data/08/00020098.jpg"}
    ListElement {imageSource: "../data/08/00020099.jpg"}
    }


    ListModel {
    id: model09
    ListElement {imageSource: "../data/09/00020100.jpg"}
    ListElement {imageSource: "../data/09/00020101.jpg"}
    ListElement {imageSource: "../data/09/00020102.jpg"}
    ListElement {imageSource: "../data/09/00020103.jpg"}
    ListElement {imageSource: "../data/09/00020104.jpg"}
    ListElement {imageSource: "../data/09/00020105.jpg"}
    ListElement {imageSource: "../data/09/00020106.jpg"}
    ListElement {imageSource: "../data/09/00020107.jpg"}
    ListElement {imageSource: "../data/09/00020108.jpg"}
    ListElement {imageSource: "../data/09/00020109.jpg"}
    ListElement {imageSource: "../data/09/00020110.jpg"}
    ListElement {imageSource: "../data/09/00020111.jpg"}
    ListElement {imageSource: "../data/09/00020112.jpg"}
    ListElement {imageSource: "../data/09/00020113.jpg"}
    ListElement {imageSource: "../data/09/00020114.jpg"}
    ListElement {imageSource: "../data/09/00020115.jpg"}
    ListElement {imageSource: "../data/09/00020116.jpg"}
    ListElement {imageSource: "../data/09/00020117.jpg"}
    ListElement {imageSource: "../data/09/00020118.jpg"}
    ListElement {imageSource: "../data/09/00020119.jpg"}
    ListElement {imageSource: "../data/09/00020120.jpg"}
    ListElement {imageSource: "../data/09/00020121.jpg"}
    ListElement {imageSource: "../data/09/00020122.jpg"}
    ListElement {imageSource: "../data/09/00020123.jpg"}
    ListElement {imageSource: "../data/09/00020124.jpg"}
    ListElement {imageSource: "../data/09/00020125.jpg"}
    ListElement {imageSource: "../data/09/00020126.jpg"}
    ListElement {imageSource: "../data/09/00020127.jpg"}
    ListElement {imageSource: "../data/09/00020128.jpg"}
    ListElement {imageSource: "../data/09/00020129.jpg"}
    ListElement {imageSource: "../data/09/00020130.jpg"}
    ListElement {imageSource: "../data/09/00020131.jpg"}
    ListElement {imageSource: "../data/09/00020132.jpg"}
    ListElement {imageSource: "../data/09/00020133.jpg"}
    ListElement {imageSource: "../data/09/00020134.jpg"}
    ListElement {imageSource: "../data/09/00020135.jpg"}
    ListElement {imageSource: "../data/09/00020136.jpg"}
    ListElement {imageSource: "../data/09/00020137.jpg"}
    ListElement {imageSource: "../data/09/00020138.jpg"}
    ListElement {imageSource: "../data/09/00020139.jpg"}
    ListElement {imageSource: "../data/09/00020140.jpg"}
    ListElement {imageSource: "../data/09/00020141.jpg"}
    ListElement {imageSource: "../data/09/00020142.jpg"}
    ListElement {imageSource: "../data/09/00020143.jpg"}
    ListElement {imageSource: "../data/09/00020144.jpg"}
    ListElement {imageSource: "../data/09/00020145.jpg"}
    ListElement {imageSource: "../data/09/00020146.jpg"}
    ListElement {imageSource: "../data/09/00020147.jpg"}
    ListElement {imageSource: "../data/09/00020148.jpg"}
    ListElement {imageSource: "../data/09/00020149.jpg"}
    ListElement {imageSource: "../data/09/00020150.jpg"}
    ListElement {imageSource: "../data/09/00020151.jpg"}
    }


    ListModel {
    id: model10
    ListElement {imageSource: "../data/10/00020152.jpg"}
    ListElement {imageSource: "../data/10/00020153.jpg"}
    ListElement {imageSource: "../data/10/00020154.jpg"}
    ListElement {imageSource: "../data/10/00020155.jpg"}
    ListElement {imageSource: "../data/10/00020156.jpg"}
    ListElement {imageSource: "../data/10/00020157.jpg"}
    ListElement {imageSource: "../data/10/00020158.jpg"}
    ListElement {imageSource: "../data/10/00020159.jpg"}
    ListElement {imageSource: "../data/10/00020160.jpg"}
    ListElement {imageSource: "../data/10/00020161.jpg"}
    ListElement {imageSource: "../data/10/00020162.jpg"}
    ListElement {imageSource: "../data/10/00020163.jpg"}
    ListElement {imageSource: "../data/10/00020164.jpg"}
    ListElement {imageSource: "../data/10/00020165.jpg"}
    ListElement {imageSource: "../data/10/00020166.jpg"}
    ListElement {imageSource: "../data/10/00020167.jpg"}
    ListElement {imageSource: "../data/10/00020168.jpg"}
    ListElement {imageSource: "../data/10/00020169.jpg"}
    ListElement {imageSource: "../data/10/00020170.jpg"}
    ListElement {imageSource: "../data/10/00020171.jpg"}
    ListElement {imageSource: "../data/10/00020172.jpg"}
    ListElement {imageSource: "../data/10/00020173.jpg"}
    ListElement {imageSource: "../data/10/00020174.jpg"}
    ListElement {imageSource: "../data/10/00020175.jpg"}
    ListElement {imageSource: "../data/10/00020176.jpg"}
    ListElement {imageSource: "../data/10/00020177.jpg"}
    ListElement {imageSource: "../data/10/00020178.jpg"}
    ListElement {imageSource: "../data/10/00020179.jpg"}
    ListElement {imageSource: "../data/10/00020180.jpg"}
    ListElement {imageSource: "../data/10/00020181.jpg"}
    ListElement {imageSource: "../data/10/00020182.jpg"}
    ListElement {imageSource: "../data/10/00020183.jpg"}
    ListElement {imageSource: "../data/10/00020184.jpg"}
    ListElement {imageSource: "../data/10/00020185.jpg"}
    ListElement {imageSource: "../data/10/00020186.jpg"}
    ListElement {imageSource: "../data/10/00020187.jpg"}
    ListElement {imageSource: "../data/10/00020188.jpg"}
    ListElement {imageSource: "../data/10/00020189.jpg"}
    ListElement {imageSource: "../data/10/00020190.jpg"}
    ListElement {imageSource: "../data/10/00020191.jpg"}
    ListElement {imageSource: "../data/10/00020192.jpg"}
    ListElement {imageSource: "../data/10/00020193.jpg"}
    }


    ListModel {
    id: model11
    ListElement {imageSource: "../data/11/00020194.jpg"}
    ListElement {imageSource: "../data/11/00020195.jpg"}
    ListElement {imageSource: "../data/11/00020196.jpg"}
    ListElement {imageSource: "../data/11/00020197.jpg"}
    ListElement {imageSource: "../data/11/00020198.jpg"}
    ListElement {imageSource: "../data/11/00020199.jpg"}
    ListElement {imageSource: "../data/11/00020200.jpg"}
    ListElement {imageSource: "../data/11/00020201.jpg"}
    ListElement {imageSource: "../data/11/00020202.jpg"}
    ListElement {imageSource: "../data/11/00020203.jpg"}
    ListElement {imageSource: "../data/11/00020204.jpg"}
    ListElement {imageSource: "../data/11/00020205.jpg"}
    ListElement {imageSource: "../data/11/00020206.jpg"}
    ListElement {imageSource: "../data/11/00020207.jpg"}
    ListElement {imageSource: "../data/11/00020208.jpg"}
    ListElement {imageSource: "../data/11/00020209.jpg"}
    ListElement {imageSource: "../data/11/00020210.jpg"}
    ListElement {imageSource: "../data/11/00020211.jpg"}
    ListElement {imageSource: "../data/11/00020212.jpg"}
    ListElement {imageSource: "../data/11/00020213.jpg"}
    ListElement {imageSource: "../data/11/00020214.jpg"}
    ListElement {imageSource: "../data/11/00020215.jpg"}
    ListElement {imageSource: "../data/11/00020216.jpg"}
    ListElement {imageSource: "../data/11/00020217.jpg"}
    ListElement {imageSource: "../data/11/00020218.jpg"}
    ListElement {imageSource: "../data/11/00020219.jpg"}
    ListElement {imageSource: "../data/11/00020220.jpg"}
    ListElement {imageSource: "../data/11/00020221.jpg"}
    ListElement {imageSource: "../data/11/00020222.jpg"}
    ListElement {imageSource: "../data/11/00020223.jpg"}
    ListElement {imageSource: "../data/11/00020224.jpg"}
    ListElement {imageSource: "../data/11/00020225.jpg"}
    ListElement {imageSource: "../data/11/00020226.jpg"}
    ListElement {imageSource: "../data/11/00020227.jpg"}
    ListElement {imageSource: "../data/11/00020228.jpg"}
    ListElement {imageSource: "../data/11/00020229.jpg"}
    ListElement {imageSource: "../data/11/00020230.jpg"}
    ListElement {imageSource: "../data/11/00020231.jpg"}
    ListElement {imageSource: "../data/11/00020232.jpg"}
    }

    ListModel {
    id: model12
    ListElement {imageSource: "../data/12/00020233.jpg"}
    ListElement {imageSource: "../data/12/00020234.jpg"}
    ListElement {imageSource: "../data/12/00020235.jpg"}
    ListElement {imageSource: "../data/12/00020236.jpg"}
    ListElement {imageSource: "../data/12/00020237.jpg"}
    ListElement {imageSource: "../data/12/00020238.jpg"}
    ListElement {imageSource: "../data/12/00020239.jpg"}
    ListElement {imageSource: "../data/12/00020240.jpg"}
    ListElement {imageSource: "../data/12/00020241.jpg"}
    ListElement {imageSource: "../data/12/00020242.jpg"}
    ListElement {imageSource: "../data/12/00020243.jpg"}
    }

//    ScrollView {
//        id: scrollview1
//        width: parent.width
//        height: parent.height

    // 外側リスト
    ListView {
        id: outer
        anchors.topMargin: 8 * dp
        anchors.fill: parent
        spacing: 8 * dp
        clip: true

        //model: 12          // ★モデル数を自動検出させたい
        model: numOfSerieses  // ★モデル数=シリーズ数
        delegate: listdelegate
    }
//    }

    Component.onCompleted: {
        //outer.currentIndex = 0;
        root.currentSeriesIndex = 0
    }

    // 外側リストのデリゲート
    Component {
        id: listdelegate                
        Item {
            id: seriesListItem
            width: parent.width
            height: col.childrenRect.height
            Row {
                id: col
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 8 * dp
                spacing: 8 * dp


                Button {
                    id: allviewButton                              // 全体/連続表示切り替えボタン
                    checked: true
                    checkable: true
                    width: 20 * dp                                       // ボタン幅
                    height: seriesList.height
                    text: "*"

                    style: ButtonStyle {
                        background: Rectangle {
                            implicitWidth: parent.width     // 100
                            implicitHeight: parent.height   // 25
                            border.width: control.activeFocus ? 2 * dp : 1 * dp
                            border.color: "#888"
                            radius: 4
                            gradient: Gradient {
                                GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                                GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                            }
                        }                        
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            allviewButton.checked = allviewButton.checked? false:true
                            root.currentSeriesIndex = index
                            //console.log("onClicked:  index=" + index )

                            seriesList.update()
                        }
                    }
                }

                // 内側リスト
                ListView {
                    id: seriesList
                    model: {
                        root.currentSeriesIndex = index
                        //console.log("model:  richListCurrentStudy.numOfSerieses)=" + richListCurrentStudy.numOfSerieses)
                        //console.log("model:  seriesList[0].imageList.length=" + richListCurrentStudy.seriesList[0].imageList.length)

                        switch(index) {
                          case 0: return previewSeriesModel0
                          case 1: return previewSeriesModel1
                          case 2: return previewSeriesModel2
                          case 3: return previewSeriesModel3
                          case 4: return previewSeriesModel4
                          case 5: return previewSeriesModel5
                          case 6: return previewSeriesModel6
                          case 7: return previewSeriesModel7
                          case 8: return previewSeriesModel8
                          case 9: return previewSeriesModel9
                          case 10: return previewSeriesModel10
                          case 11: return previewSeriesModel11
                          case 12: return previewSeriesModel12
                          case 13: return previewSeriesModel13
                          case 14: return previewSeriesModel14
                          case 15: return previewSeriesModel15
                          case 16: return previewSeriesModel16
                          case 17: return previewSeriesModel17
                          case 18: return previewSeriesModel18
                          case 19: return previewSeriesModel19
                          case 20: return previewSeriesModel20
                          case 21: return previewSeriesModel21
                          case 22: return previewSeriesModel22
                          case 23: return previewSeriesModel23
                          case 24: return previewSeriesModel24
                          case 25: return previewSeriesModel25
                          case 26: return previewSeriesModel26
                          case 27: return previewSeriesModel27
                          case 28: return previewSeriesModel28
                          case 29: return previewSeriesModel29
                          case 30: return previewSeriesModel30
                          case 31: return previewSeriesModel31
                          case 32: return previewSeriesModel32
                          case 33: return previewSeriesModel33
                          case 34: return previewSeriesModel34
                          case 35: return previewSeriesModel35
                          case 36: return previewSeriesModel36
                          case 37: return previewSeriesModel37
                          case 38: return previewSeriesModel38
                          case 39: return previewSeriesModel39
                          case 40: return previewSeriesModel40
                          case 41: return previewSeriesModel41
                          case 42: return previewSeriesModel42
                          case 43: return previewSeriesModel43
                          case 44: return previewSeriesModel44
                          case 45: return previewSeriesModel45
                          case 46: return previewSeriesModel46
                          case 47: return previewSeriesModel47
                          case 48: return previewSeriesModel48
                          case 49: return previewSeriesModel49
                        }
                    }

                    contentHeight: contentItem.childrenRect.height
                    height: childrenRect.height
                    width: parent.width
                    clip: true
                    // spacing: 2
                    orientation: Qt.Horizontal

                    delegate: Image {
                        id: thumbimg
                        height: 80 * dp
                        width: {
                            var cellWidth = (80 + 4) * dp                                  // １画像に割り当てる幅: オリジナル画像幅 + 左右余白
                            if( !allviewButton.checked ) return cellWidth           // 連続表示の場合
                            if( allviewButton.checked ) return cellWidth     //★★非連続表示がまだできていないため　一時的に常に連続表示

                            // 全体を表示するように画像を間引く
                            var syuuyousu = Math.floor((seriesList.width - 30 * dp) / cellWidth)     // 1行に表示できる画像数 (-値は実機で求めた適当な調整値)
                            //console.log("*** syuuyousu=" + syuuyousu )

                            //var gazosu = seriesList.model.count                     // 現在のシリーズの画像数
                            var gazosu=richListCurrentStudy.seriesList[currentSeriesIndex].imageList.length  // 現在のシリーズの画像数
                            //console.log("*** gazosu=" + gazosu)

                            var gazosuPerCell = Math.floor(gazosu/syuuyousu)
                            if(gazosu <= syuuyousu) return cellWidth                // 一度に全ての画像を表示できる場合

                            // 間引いて表示
                            if((index + 1) >= (syuuyousu * gazosuPerCell)) {
                                //console.log(index, syuuyousu, gazosuPerCell, 0)
                                return 0
                             }
                            var ret = (index % gazosuPerCell ) ? 0: cellWidth  // 間引いて表示
                            //console.log(index, syuuyousu, gazosuPerCell, (index % gazosuPerCell), ret)
                            return ret
                        }

                        source: imageSource
                        fillMode: Image.PreserveAspectFit   // ストレッチさせない

                        Behavior on width { NumberAnimation {duration: 2000; easing.type: Easing.OutElastic } } // アニメ効果
                    }
                }
            }
        }
    }
}
