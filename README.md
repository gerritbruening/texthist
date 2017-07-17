# texthist

Some public material from my research about textual history. 

## sample data

### k-proc-text
```
<P PN=7><PP PN=7><LN N=2>2 
Jemand mußte Josef K. verleumdet haben, denn ohne 
<LN N=3>3 
daß er etwas Böses getan hätte, wurde er eines Morgens
```

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

The code is a true representation of all these elements and their typographic rendering:
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