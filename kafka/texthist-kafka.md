Kafka's novels
=====
# focus

## compare manuscript text, editio princeps and following editions by Max Brod
Test and maybe improve martians.py on ms. vs. editio princeps
* Get plain versions of manuscript text and first printed edition (DTA)
* compare them to get `[-...-]{+...+}` style variants
* run [martians.py](https://github.com/dh-trier/martian/blob/master/collation/martians.py) on it, see if any variants are classified correctly

## in-depth analysis of manuscript variants
The general idea would be transform `text` and `app` (see sample data below) in one proper TEI XML encoding and then run analyses on this material, e.g.
* how many words hat been originally written on one manuscript page? (text prior to all alterations would have to be used)
* how much of the text is affected by `subst`, `del` and `add` nodes, i.e., subject to variants?

However, this requires complex preprocessing, since 
* app entries are encoded on the basis of their typographic appearance 
* app entries are linked to the text via human-readable pointers which would have to be parsed and interpreted

# data

## Kafka's "Process" -- text
The digital version of the KKA uses SGML that may be copied manually (but only piecemeal) from the GUI ("Bearbeiten", "SGML kopieren"). 
Here is a snippet: 
```
<P PN=7><PP PN=7><LN N=2>2 
Jemand mußte Josef K. verleumdet haben, denn ohne 
<LN N=3>3 
daß er etwas Böses getan hätte, wurde er eines Morgens 
<LN N=4>4 
verhaftet. Die Köchin der Frau Grubach, seiner Zimmervermieterin,
```
The SGML is generated from a simplified code that comes without any explicit tag delimiters:
```
PN=7PN=7PN=7N=2Jemand mußte Josef K. verleumdet haben, denn ohne
N=3daß er etwas Böses getan hätte, wurde er eines Morgens
N=4verhaftet. Die Köchin der Frau Grubach, seiner Zimmervermieterin,
```
This code can be copied in one go. 
It is processed into a TEI-like XML by [ka2xml.xml](kafka/ka2xml.xml). 

### Page vs. paragraph breaks
It is important do distinguish page from paragraph breaks:
```
N=25nicht verstehe, das man aber auch nicht verstehen muß."PN=33PN=33      N=26"Es ist gar nichts Dummes, was Sie gesagt haben Frau
N=27Grubach, wenigstens bin auch ich zum Teil Ihrer Meinung,
PN=34N=34 IDPAGE=KKAPp34 PN=34RID=007VA034 TYPE=ALT TEXT="Varianten"PN=34N=1nur urteile ich über das ganze noch schärfer als
```
The first event is a paragraph break, the second is 
a page break. It seems as if the paragraph break is  
marked by "PN=`\d+`PN=`d\+`" followed by 6 `no-break space`s whereas the 
page break has a whole bunch of explicit markup.

### Page breaks and paragraph breaks coinciding
`N=27die Treppe hinaufstieg, drehte er sich noch einmal um.PN=32N=32 IDPAGE=KKAPp32 PN=32RID=007VA032 TYPE=ALT TEXT="Varianten"PN=32PN=32      N=1Er hätte geradewegs in sein Zimmer gehen können,`

When page breaks and paragraph breaks are coinciding, the above 
mentioned markings are simply concatinated.

## Kafka's "Process" -- apparatus
Before looking at the code, take a look on the original apparatus entry which covers for the variants in the autograph manuscript.
This is how it looks like:

![grafik](https://github.com/gerritbruening/texthist/blob/master/kafka/sample-data/img/k-app_7%2C3-4.PNG)

Explanations:
- `7` is the page number reference.
- `3–4` is the line number reference.
- `wurde ... verhaftet` is the passage in the reading text to which the following reading corresponds to. It is delimited by the bold closing angle bracket. 
- `[...]` was deleted in the manuscript.
- `〈...〉` was added.

The following SGML code is a true representation of all these elements and their typographic rendering:
```
<N HANG=Y PN=161><A><LI>3 – 4
</LI></A> wurde ... verhaftet
<BO>]
</BO> [war] 
&lsaquo;á
wurde
&rsaquo;ñ
 er eines Morgens [gefangen] 
&lsaquo;á
verhaftet
&rsaquo;ñ
</N>
```
Note that the `&lsaquo;á` etc. are for the angle brackets.

This is the original code:
`HANG=Y PN=1613 – 4 wurde ... verhaftet] [war] name='lsaquo' font=symbol code=0225 charset=symbolwurdename='rsaquo' font=symbol code=0241 charset=symbol er eines Morgens [gefangen] name='lsaquo' font=symbol code=0225 charset=symbolverhaftetname='rsaquo' font=symbol code=0241 charset=symbol`
This is quite untidy.
1. We need the preceding information that the variant occurs on page 7 of the reading text: `COMHEAD="Der Proceß (Apparatband): Varianten zu S. 7"`.
1. The line reference `3 -- 4` is stuck together with the (by and large irrelevant) page number of the apparatus page `PN=161`. Note that the line reference may be double digit such as in `PN=16112` which refers to line 12 of the same page in the reading text.
1. `charset=symbolwurdename='rsaquo'` looks ugly but will be easy to handle.

On the whole it still seems that the original code is sufficient for further processing.

## Interprete text and app code in terms of TEI
Now, in terms of TEI XML the text and apparatus data in combination mean the following:

         <pb n="7"/>
         <p><lb n="2"/>Jemand mußte Josef K. verleumdet haben, denn ohne<lb
               n="3"/>daß er etwas Böses getan hätte, <subst>
               <del>war</del>
               <add>wurde</add>
            </subst> er eines Morgens<lb n="4"/><subst>
               <del>gefangen</del>
               <add>verhaftet</add>
            </subst>. Die Köchin der Frau Grubach, seiner Zimmervermieterin,
            <!-- ... --></p>
            
            
## software

### fka.xml
TXSTEP #kopiere script to transform docx import some pieces of the "Process" from the historisch-kritische Franz Kafka-Ausgabe (FKA) to TEI.

### proc.xml
TXSTEP script to collate four versions of Kafka's "Prozess": 
1. Franz Kafka, Der Prozess. Roman, Berlin 1925, taken from the [Deutsches Textarchiv](http://www.deutschestextarchiv.de/dtaq/book/show/kafka_prozess_1925) (base text)
1. Franz Kafka, Gesammelte Werke. Band 1, Frankfurt a.M. 1950 ff., taken from [zeno.org](http://www.zeno.org/Literatur/M/Kafka,+Franz/Romane/Der+Proze%C3%9F). A derivative TEI encoded version of this text is to be found in Textgrid.
2. Franz Kafka, Der Prozeß, Frankfurt am Main, Hamburg 1962 (Fischer Bücherei)
3. transcription of the "Prozess" in the Kritische Ausgabe (Fischer), taken from ["The critical edition in German of «The Trial» («Der Proceß» )"](http://www.kafka.org/index.php?trial) (kafka.org)