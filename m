Return-Path: <SRS0=Jbst=P4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33434C7113D
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF552085A
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 16:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfATQEN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:04:13 -0500
Received: from maillog.nuvoton.com ([202.39.227.15]:36992 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfATQEN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Jan 2019 11:04:13 -0500
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jan 2019 11:04:12 EST
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 419621C80612;
        Sun, 20 Jan 2019 23:53:50 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Sun, 20 Jan 2019
 23:53:49 +0800
Received: from NTILML02.nuvoton.com (10.190.1.47) by NTILML02.nuvoton.com
 (10.190.1.47) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Sun, 20 Jan
 2019 17:53:46 +0200
Received: from NTILML02.nuvoton.com ([::1]) by NTILML02.nuvoton.com ([::1])
 with mapi id 15.00.1130.005; Sun, 20 Jan 2019 17:53:46 +0200
From:   <Dan.Morav@nuvoton.com>
To:     <nayna@linux.vnet.ibm.com>, <oshri.alkoby@nuvoton.com>,
        <dana.cohen@nuvoton.com>
CC:     <linux-integrity@vger.kernel.org>, <gcwilson@us.ibm.com>
Subject: RE: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Topic: device tree "compatible" string value for Nuvoton TPM 75xxx
Thread-Index: AQHUr0NnAtI+NFiTokGDUz1xZWqLqqW4UMeg
Date:   Sun, 20 Jan 2019 15:53:46 +0000
Message-ID: <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
In-Reply-To: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.191.10.151]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGksDQoNCkkndmUgYWRkZWQgT3Nocmkgd2hvIGhhcyBiZWVuIHdvcmtpbmcgb24gdGhlIGRyaXZl
ciwgYW5kIERhbmEgd2hvIGlzIHRoZSBUUE0gYXBwbGljYXRpb25zIGZvciBmb2xsb3cgdXAuDQpJ
J2Qgc3VnZ2VzdCAibnBjdDc1eCIgdG8gY29udGludWUgd2l0aCB0aGUgc2FtZSBsaW5lLg0KDQpS
ZWdhcmRzLA0KRGFuLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmF5bmEg
PG5heW5hQGxpbnV4LnZuZXQuaWJtLmNvbT4NClNlbnQ6IEZyaWRheSwgMTggSmFudWFyeSwgMjAx
OSAxNzozNQ0KVG86IElTMzAgRGFuIE1vcmF2IDxEYW4uTW9yYXZAbnV2b3Rvbi5jb20+DQpDYzog
bGludXgtaW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZzsgZ2N3aWxzb25AdXMuaWJtLmNvbQ0KU3Vi
amVjdDogZGV2aWNlIHRyZWUgImNvbXBhdGlibGUiIHN0cmluZyB2YWx1ZSBmb3IgTnV2b3RvbiBU
UE0gNzV4eHgNCg0KSGksDQoNCkN1cnJlbnRseSwgdGhlIGtlcm5lbCBzdXBwb3J0cyAibnV2b3Rv
bixucGN0NjAxIiBmb3IgTnV2b3RvbiBUUE0gMi4NCg0KSSB3YXMgd29uZGVyaW5nIHdoYXQgd2ls
bCBiZSB0aGUgY29tcGF0aWJsZSBzdHJpbmcgdmFsdWUgZm9yIE51dm90b24gVFBNIDc1eHggbW9k
ZWxzLg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KDQogICAgICAtIE5heW5hDQoNCg0KDQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGUgcHJpdmlsZWdlZCBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgaXMgaW50ZW5kZWQgZm9yIHVzZSBv
bmx5IGJ5IHRoZSBhZGRyZXNzZWVzIGFzIGluZGljYXRlZCBieSB0aGUgb3JpZ2luYWwgc2VuZGVy
IG9mIHRoaXMgZW1haWwuIElmIHlvdSBhcmUgbm90IHRoZSBhZGRyZXNzZWUgaW5kaWNhdGVkIGlu
IHRoaXMgZW1haWwgb3IgYXJlIG5vdCByZXNwb25zaWJsZSBmb3IgZGVsaXZlcnkgb2YgdGhlIGVt
YWlsIHRvIHN1Y2ggYSBwZXJzb24sIHBsZWFzZSBraW5kbHkgcmVwbHkgdG8gdGhlIHNlbmRlciBp
bmRpY2F0aW5nIHRoaXMgZmFjdCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgaXQgZnJvbSB5b3Vy
IGNvbXB1dGVyIGFuZCBuZXR3b3JrIHNlcnZlciBpbW1lZGlhdGVseS4gWW91ciBjb29wZXJhdGlv
biBpcyBoaWdobHkgYXBwcmVjaWF0ZWQuIEl0IGlzIGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3Jp
emVkIHVzZSBvZiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gb2YgTnV2b3RvbiBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkOyBhbmQgYW55IGluZm9ybWF0aW9uIGluIHRoaXMgZW1haWwgaXJyZWxldmFu
dCB0byB0aGUgb2ZmaWNpYWwgYnVzaW5lc3Mgb2YgTnV2b3RvbiBzaGFsbCBiZSBkZWVtZWQgYXMg
bmVpdGhlciBnaXZlbiBub3IgZW5kb3JzZWQgYnkgTnV2b3Rvbi4NCg==
