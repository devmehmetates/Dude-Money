# Dude-Money
 Hesap paylaştırma uygulaması

## Viper Pattern
### Yapılması gerekenler

- **Ortak**: Patternin ana kullanımında P.O.P kullanıldığı için katmanların tamamı için Interface oluşturulmalı. Interface'ler katmanların görevlerinin belirlendiği ve katmanı açıkça belli eden protokoller.

- **Router**: Sayfanının navigation işlemlerinin ve en önemlisi(bence) sayfanın initilize edilmesini sağlıyor. Initilize static bir method, view'i ve tüm katmanlarını oluşturup sunuyor. Kendine özgü push ve pop methodlarına sahip olabilir.

- **Presenter**: View ve diğer katmanlar arasında ki bağlantı. Viewda gerçekleşen herhangi bir olayın diğer katmanlarla bir işi olup olmadığına karar veriyor. Kısaca logic katmanı. Business işleri yapılmıyor.

- **Interactor**: Tek bağlantısı presenter. Diğer katmanlar ona direkt olarak erişemiyor. Business işleri burada yapılıyor. Kısaca servislerin kullanım alanı.

- **View**: Kullanıcı arayüzü. Herhangi bir logic içermez. Diğer katmanlarla presenter üzerinden iletişim kurabilir.

- **Entity**: Klasik model katmanı. Servisten gelen verilerin presenter üzerinde işlendip dönüştüğü modeller. 

## Tabbar
Projeyi tabbar üzerinden runlayıp presenter routerların create methodlarını kullanıp modüllerin ayağa kaldırılması gerekiyor. Böylece **Viper** canlanacak 🐍

