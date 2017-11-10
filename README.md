# texthist

Some public material from my research about textual history. 

## sample data

### k-proc-text
SGML snippet as may be copied manually ("Bearbeiten", "SGML kopieren") from the GUI:
```
<P PN=7><PP PN=7><LN N=2>2 
Jemand mußte Josef K. verleumdet haben, denn ohne 
<LN N=3>3 
daß er etwas Böses getan hätte, wurde er eines Morgens 
<LN N=4>4 
verhaftet. Die Köchin der Frau Grubach, seiner Zimmervermieterin,
```
Corresponding original code from which the above SGML code is generated:
```
PN=7PN=7PN=7N=2Jemand mußte Josef K. verleumdet haben, denn ohne
N=3daß er etwas Böses getan hätte, wurde er eines Morgens
N=4verhaftet. Die Köchin der Frau Grubach, seiner Zimmervermieterin,
```
This seems to be equivalent to the above code so that it may serve as a proper basis for further processing.

####Page vs. paragraph breaks
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

####Page breaks and paragraph breaks coinciding
```
N=27die Treppe hinaufstieg, drehte er sich noch einmal um.PN=32N=32 IDPAGE=KKAPp32 PN=32RID=007VA032 TYPE=ALT TEXT="Varianten"PN=32PN=32      N=1Er hätte geradewegs in sein Zimmer gehen können,
```
When page breaks and paragraph breaks are coinciding, the above 
mentioned markings are simply concatinated.

### k-proc-app
Before looking at the code, take a look on the original apparatus entry which covers for the variants in the autograph manuscript.
This is how it looks like:

![grafik](https://github.com/gerritbruening/texthist/blob/master/sample-data/img/k-app_7%2C3-4.PNG)

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

### Interprete text and app code in terms of TEI
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

The general idea would be transform `text` and `app` in one proper TEI XML encoding and then run analyses on this material, e.g.
* how many words hat been originally written on one manuscript page? (text prior to all alterations would have to be used)
* how much of the text is affected by `subst`, `del` and `add` nodes, i.e., subject to variants?
