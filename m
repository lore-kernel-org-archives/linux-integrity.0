Return-Path: <SRS0=H4GS=QL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C44C282C4
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 16:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC14A20823
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Feb 2019 16:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfBDQjv (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:39:51 -0500
Received: from maillog.nuvoton.com ([202.39.227.15]:46736 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfBDQjv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Feb 2019 11:39:51 -0500
Received: from NTHCCAS01.nuvoton.com (nthccas01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 33C171C80C1A;
        Tue,  5 Feb 2019 00:39:47 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 5 Feb 2019
 00:39:45 +0800
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Mon, 4 Feb
 2019 18:39:42 +0200
Received: from NTILML02.nuvoton.com ([::1]) by NTILML02.nuvoton.com ([::1])
 with mapi id 15.00.1130.005; Mon, 4 Feb 2019 18:39:42 +0200
From:   <oshri.alkoby@nuvoton.com>
To:     <nayna@linux.vnet.ibm.com>, <Dan.Morav@nuvoton.com>, <jgg@ziepe.ca>
CC:     <dana.cohen@nuvoton.com>, <linux-integrity@vger.kernel.org>,
        <gcwilson@us.ibm.com>
Subject: RE: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Topic: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Index: AQHUr0NnAtI+NFiTokGDUz1xZWqLqqW4UMeggACQpgCAAOD0kIADkeEPgAyIhACABgRhwA==
Date:   Mon, 4 Feb 2019 16:39:41 +0000
Message-ID: <5d8a2c4e92354d25889198c1a16ed7db@NTILML02.nuvoton.com>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
 <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
 <20190121022640.GD18017@ziepe.ca>
 <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com>
 <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com>
 <16c939bd-0b32-71cf-094e-ae3cc0546ad6@linux.vnet.ibm.com>
 <08f7532a-b5cd-df2d-c8f9-b363a713882b@linux.vnet.ibm.com>
In-Reply-To: <08f7532a-b5cd-df2d-c8f9-b363a713882b@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [72.182.52.39]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbSBvdXIgZW5kIHdlIGFyZSBmaW5lIHdpdGggd2hhdCBKYXNvbiBzdWdnZXN0ZWQsIHdlIGNh
biBhZGQgYSBzcGVjaWZpYyBkZXZpY2U6DQonbnV2b3RvbixucGN0NzUwJywndGNnLHRwbS1pMmMt
cHRwJw0KDQpPc2hyaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmF5bmEg
W21haWx0bzpuYXluYUBsaW51eC52bmV0LmlibS5jb21dDQpTZW50OiBUaHVyc2RheSwgSmFudWFy
eSAzMSwgMjAxOSAzOjQ2IFBNDQpUbzogSVMyMCBPc2hyaSBBbGtvYnkgPG9zaHJpLmFsa29ieUBu
dXZvdG9uLmNvbT47IElTMzAgRGFuIE1vcmF2IDxEYW4uTW9yYXZAbnV2b3Rvbi5jb20+OyBqZ2dA
emllcGUuY2ENCkNjOiBJUzMwIERhbmEgQ29oZW4gPGRhbmEuY29oZW5AbnV2b3Rvbi5jb20+OyBs
aW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBnY3dpbHNvbkB1cy5pYm0uY29tDQpTdWJq
ZWN0OiBSZTogZGV2aWNlIHRyZWUgImNvbXBhdGlibGUiIHN0cmluZyB2YWx1ZSBmb3IgTnV2b3Rv
biBUUE0gNzV4eHgNCg0KDQoNCk9uIDAxLzIzLzIwMTkgMDM6MjIgUE0sIE5heW5hIHdyb3RlOg0K
Pg0KPg0KPiBPbiAwMS8yMS8yMDE5IDExOjU1IEFNLCBvc2hyaS5hbGtvYnlAbnV2b3Rvbi5jb20g
d3JvdGU6DQo+PiBIaSBKYXNvbiwNCj4+DQo+PiBTaW5jZSB0aGUgZHJpdmVyIGltcGxlbWVudHMg
dGhlIEkyQyBpbnRlcmZhY2UgZGVmaW5lZCBieSB0aGUgVENHIFBUUCwNCj4+IHdvdWxkbid0IGl0
IGJlIGJldHRlciB0byBzZXQgdGhlIHN0cmluZyB0byBiZSBzb21ldGhpbmcgbGlrZQ0KPj4gJ3Rj
Zyx0cG0taTJjLXB0cCcgKGFzICd0Y2csdHBtLXRpcy1tbWlvJyBmb3IgdHBtLXRpcyk/DQo+PiBB
bnkgVFBNIHRoYXQgaW1wbGVtZW50cyB0aGlzIHByb3RvY29sIGNhbiB1c2UgdGhpcyBkcml2ZXIu
DQo+DQo+IEl0IG1pZ2h0IGJlIG5pY2UgdG8gaGF2ZSBhIGdlbmVyaWMgbmFtZSBpZiBpdCBpcyBh
bHNvIGNvbXBsaWFudCB3aXRoDQo+IHRoZSBkZXZpY2UgdHJlZSBzcGVjaWZpY2F0aW9uLg0KPiBI
b3dldmVyLCBJIHdhcyB3b25kZXJpbmcgaWYgaXQgd2lsbCBub3QgcmVxdWlyZSBkcml2ZXIgY29k
ZSBjaGFuZ2VzIGFzDQo+IHdlbGwgYmVmb3JlIHRoaXMgZ2VuZXJpYyBuYW1lIGNhbiBiZSB1c2Vk
IGJ5IGFueSBUUE0gaW1wbGVtZW50aW5nIGkyYw0KPiBwcm90b2NvbCA/DQoNCkkgYW0gd29uZGVy
aW5nIGlmIGFueXRoaW5nIGdvdCBkZWNpZGVkIG9uIHRoaXMgPw0KDQpUaGFua3MgJiBSZWdhcmRz
LA0KICAgICAgICAtIE5heW5hDQoNCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQpUaGUgcHJpdmlsZWdlZCBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gY29udGFpbmVkIGlu
IHRoaXMgZW1haWwgaXMgaW50ZW5kZWQgZm9yIHVzZSBvbmx5IGJ5IHRoZSBhZGRyZXNzZWVzIGFz
IGluZGljYXRlZCBieSB0aGUgb3JpZ2luYWwgc2VuZGVyIG9mIHRoaXMgZW1haWwuIElmIHlvdSBh
cmUgbm90IHRoZSBhZGRyZXNzZWUgaW5kaWNhdGVkIGluIHRoaXMgZW1haWwgb3IgYXJlIG5vdCBy
ZXNwb25zaWJsZSBmb3IgZGVsaXZlcnkgb2YgdGhlIGVtYWlsIHRvIHN1Y2ggYSBwZXJzb24sIHBs
ZWFzZSBraW5kbHkgcmVwbHkgdG8gdGhlIHNlbmRlciBpbmRpY2F0aW5nIHRoaXMgZmFjdCBhbmQg
ZGVsZXRlIGFsbCBjb3BpZXMgb2YgaXQgZnJvbSB5b3VyIGNvbXB1dGVyIGFuZCBuZXR3b3JrIHNl
cnZlciBpbW1lZGlhdGVseS4gWW91ciBjb29wZXJhdGlvbiBpcyBoaWdobHkgYXBwcmVjaWF0ZWQu
IEl0IGlzIGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIHVzZSBvZiBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gb2YgTnV2b3RvbiBpcyBzdHJpY3RseSBwcm9oaWJpdGVkOyBhbmQgYW55IGlu
Zm9ybWF0aW9uIGluIHRoaXMgZW1haWwgaXJyZWxldmFudCB0byB0aGUgb2ZmaWNpYWwgYnVzaW5l
c3Mgb2YgTnV2b3RvbiBzaGFsbCBiZSBkZWVtZWQgYXMgbmVpdGhlciBnaXZlbiBub3IgZW5kb3Jz
ZWQgYnkgTnV2b3Rvbi4NCg==
