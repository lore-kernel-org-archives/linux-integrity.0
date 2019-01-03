Return-Path: <SRS0=i0te=PL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73409C43387
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7BA208E3
	for <linux-integrity@archiver.kernel.org>; Thu,  3 Jan 2019 15:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfACPea (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:34:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:59380 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730901AbfACPe3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jan 2019 10:34:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 07:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="115199392"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2019 07:34:28 -0800
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 3 Jan 2019 07:34:28 -0800
Received: from hasmsx105.ger.corp.intel.com (10.184.198.19) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 3 Jan 2019 07:34:27 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.79]) by
 HASMSX105.ger.corp.intel.com ([169.254.1.69]) with mapi id 14.03.0415.000;
 Thu, 3 Jan 2019 17:34:24 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
Thread-Topic: [PATCH] tpm: fix incorrect success returns from
 tpm_try_transmit()
Thread-Index: AQHUoTaDP3+Er/wooEum4hDGaSfDgKWdZEEAgAAofACAACNzUA==
Date:   Thu, 3 Jan 2019 15:34:24 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA626D3@hasmsx108.ger.corp.intel.com>
References: <1546280851.3079.2.camel@HansenPartnership.com>
         <20190103125904.GA10491@linux.intel.com>
 <1546529038.2824.6.camel@HansenPartnership.com>
In-Reply-To: <1546529038.2824.6.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDkyMDA2ZWEtZjllNi00NDk1LWI1NjEtYjYxZDRmNTRhYjI2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic1l0Z1QyUTJlSk0xeTB1ZWZ5NURMdDVza0V2OVJLNVdJZDA0T2Q0UWRqTnBZdldVVk5hZFk0UWU5dG0yWFlVQyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.254.144.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQm90dG9tbGV5
IFttYWlsdG86SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbV0NCj4gU2VudDog
VGh1cnNkYXksIEphbnVhcnkgMDMsIDIwMTkgMTc6MjQNCj4gVG86IEphcmtrbyBTYWtraW5lbiA8
amFya2tvLnNha2tpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IFdpbmtsZXIsIFRvbWFzIDx0
b21hcy53aW5rbGVyQGludGVsLmNvbT47IGxpbnV4LQ0KPiBpbnRlZ3JpdHlAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRwbTogZml4IGluY29ycmVjdCBzdWNjZXNzIHJl
dHVybnMgZnJvbSB0cG1fdHJ5X3RyYW5zbWl0KCkNCj4gDQo+IE9uIFRodSwgMjAxOS0wMS0wMyBh
dCAxNDo1OSArMDIwMCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0KPiA+IE9uIE1vbiwgRGVjIDMx
LCAyMDE4IGF0IDEwOjI3OjMxQU0gLTA4MDAsIEphbWVzIEJvdHRvbWxleSB3cm90ZToNCj4gPiA+
IEV2ZXIgc2luY2UgNjI3NDQ4ZTg1Yzc2NiAidHBtOiBzZXBhcmF0ZSBjbWRfcmVhZHkvZ29faWRs
ZSBmcm9tDQo+ID4gPiBydW50aW1lX3BtIiB3ZSBoYXZlIGJlZW4gcmV0dXJuaW5nIHN1Y2Nlc3Mg
ZnJvbSB0cG1fdHJ5X3RyYW5zbWl0KCkNCj4gPiA+IGV2ZW4gaWYgYW4gZXJyb3Igb2NjdXJyZWQu
ICBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGludHJvZHVjdGlvbiBvZg0KPiA+ID4gcmMgPSB0cG1f
Z29faWRsZSgpIGF0IHRoZSBlbmQgb2YgcHJvY2Vzc2luZyBvdmVyd3JpdGVzIHRoZSB2YWx1ZSBv
Zg0KPiA+ID4gcmMgaWYgaXQgY29udGFpbnMgYW4gZXJyb3IgY29kZSAobW9zdGx5IHdpdGggc3Vj
Y2VzcykuICBGaXggdGhpcyBieQ0KPiA+ID4gd3JpdGluZyB0aGUgcmV0dXJuIHRvIGEgbmV3IHZh
cmlhYmxlIHJjMSBpbnN0ZWFkLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA2Mjc0NDhlODVjNzY2ICJ0
cG06IHNlcGFyYXRlIGNtZF9yZWFkeS9nb19pZGxlIGZyb20NCj4gPiA+IHJ1bnRpbWVfcG0iDQo+
ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFt
ZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuYw0KPiA+ID4g
b20+DQo+ID4gPg0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gTm90ZTogdGhlIGdvdG8gb3V0IGxv
b2tzIGZpc2h5IGFzIHdlbGwuICBUaGUgb25seSBnb19pZGxlDQo+ID4gPiBpbXBsZW1lbnRvciBp
cyB0cG1fY3JiIGFuZCB0aGF0IGNhbiByZXR1cm4gYSB0aW1lb3V0IGFzIC1FVElNRSwgc28NCj4g
PiA+IGl0IGxvb2tzIGxpa2UgaXQgd291bGQgdGhlbiBsb29wIGZvcmV2ZXINCj4gPiA+DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG0taW50ZXJmYWNlLmMNCj4gPiA+IGIv
ZHJpdmVycy9jaGFyL3RwbS90cG0taW50ZXJmYWNlLmMNCj4gPiA+IGluZGV4IDEyOWY2NDA0MjRi
Ny4uYWM3ZWJhYjYxNDBjIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0t
aW50ZXJmYWNlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtLWludGVyZmFjZS5j
DQo+ID4gPiBAQCAtNDMyLDcgKzQzMiw3IEBAIHN0YXRpYyBzc2l6ZV90IHRwbV90cnlfdHJhbnNt
aXQoc3RydWN0IHRwbV9jaGlwDQo+ID4gPiAqY2hpcCwNCj4gPiA+ICAJCQkJdW5zaWduZWQgaW50
IGZsYWdzKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IHRwbV9vdXRwdXRfaGVhZGVyICpoZWFk
ZXIgPSAodm9pZCAqKWJ1ZjsNCj4gPiA+IC0JaW50IHJjOw0KPiA+ID4gKwlpbnQgcmMsIHJjMTsN
Cj4gPiA+ICAJc3NpemVfdCBsZW4gPSAwOw0KPiA+ID4gIAl1MzIgY291bnQsIG9yZGluYWw7DQo+
ID4gPiAgCXVuc2lnbmVkIGxvbmcgc3RvcDsNCj4gPiA+IEBAIC01NDcsOCArNTQ3LDggQEAgc3Rh
dGljIHNzaXplX3QgdHBtX3RyeV90cmFuc21pdChzdHJ1Y3QgdHBtX2NoaXANCj4gPiA+ICpjaGlw
LA0KPiA+ID4gIAkJZGV2X2VycigmY2hpcC0+ZGV2LCAidHBtMl9jb21taXRfc3BhY2U6IGVycm9y
ICVkXG4iLCByYyk7DQo+ID4gPg0KPiA+ID4gIG91dDoNCj4gPiA+IC0JcmMgPSB0cG1fZ29faWRs
ZShjaGlwLCBmbGFncyk7DQo+ID4gPiAtCWlmIChyYykNCj4gPiA+ICsJcmMxID0gdHBtX2dvX2lk
bGUoY2hpcCwgZmxhZ3MpOw0KPiA+ID4gKwlpZiAocmMxKQ0KPiA+ID4gIAkJZ290byBvdXQ7DQo+
ID4gPg0KPiA+ID4gIAlpZiAobmVlZF9sb2NhbGl0eSkNCj4gPg0KPiA+IFRoYW5rcyBKYW1lcyBh
bmQgc29ycnkgZm9yIGxhdGVuY3kgKGhvbGlkYXkgc2Vhc29uKS4gSnVzdCBhIHNtYWxsDQo+ID4g
c3VnZ2VzdGlvbi4gSSB3b3VsZCBqdXN0Og0KPiA+DQo+ID4gaWYgKHRwbV9nb19pZGxlKGNoaXAs
IGZsYWdzKSkNCj4gPiAJZ290byBvdXQ7DQo+ID4NCj4gPiBXaGF0IGRvIHlvdSB0aGluaz8NCj4g
DQo+IFRoYXQgaXQgZG9lc24ndCBzb2x2ZSB0aGUgbG9vcCBmb3JldmVyIHdpdGggbm8gd2Fybmlu
ZyBwcm9ibGVtLiAgSWYgYW55dGhpbmcsIEkNCj4gdGhpbmsgdGhlIGNvcnJlY3QgdGhpbmcgaXMg
cHJvYmFibHkNCj4gDQo+IAlyYzEgPSB0cG1fZ29faWRsZShjaGlwLCBmbGFncyk7DQo+IAlpZiAo
cmMxKQ0KPiAgIAkJZGV2X2VycigmY2hpcC0+ZGV2LCAiZ28gaWRsZSBmYWlsZWQgd2l0aCAlZFxu
IiwgcmMxKTsNCj4gDQo+IHNvIHdlIGxvZyB0aGUgcHJvYmxlbSBhbmQgbW92ZSBvbi4gIElmIGl0
IGlzIGEgdGltZW91dCwgaXQgd2lsbCBsaWtlbHkgc2hvdyB1cCBvbg0KPiB0aGUgbmV4dCBUUE0g
b3BlcmF0aW9uLiAgU2luY2UgdGhpcyBpcyB0aGUgb25seSBjYWxsZXIgb2YgdHBtX2dvX2lkbGUo
KSwgSSB0aGluayBhbGwNCj4gbG9vcGluZyBzaG91bGQgYmUgZG9uZSBpbnNpZGUgdGhhdCBmdW5j
dGlvbiwgYnV0IHdlIHNob3VsZCBwcm9iYWJseSB3YWl0IGZvcg0KPiBUb21hcyB0byBjb21tZW50
IHNpbmNlIGhlIHdyb3RlIGl0Lg0KPiANCg0KV2UndmUgYWxyZWFkeSBmaXhlZCBpdCwgSSBmb3Jn
b3QgbXlzZWxmICwgd2Ugd2VyZSBkcmlua2luZyB0b28gbXVjaCA6KQ0KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8xMDY0MzU2NS8NCk5vdCBzdXJlIHdoeSBpdCB3YXMgZHJvcHBl
ZC4NCg0KVGhhbmtzDQpUb21hcw0KDQoNCg==
