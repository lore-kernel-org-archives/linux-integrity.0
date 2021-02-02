Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEABC433DB
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Feb 2021 22:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FB364F7F
	for <linux-integrity@archiver.kernel.org>; Tue,  2 Feb 2021 22:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhBBWMQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:12:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:33745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhBBWLh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 17:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612303791;
        bh=sublxeZ2VdLTZOYDOVxM+X8ex27NO+96YlL0ZNTFJxs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PkRJvcDLSZC1Ze25SyrmNsljKdPb2EPg5f9wjppGwRkQWYhfSG8gMhdDXq/n+Xb/W
         Ink/70j5z6a13jrKvewgmJVXDh62xYRqUSTpCbVuzL3fQmJ7EvrLL7x01CiAOGEaLO
         kiQJzsDJSQcnpC34vZFypoa3T2+e12hHZ2Xbu8hw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1l9r9B2pUw-00G2vb; Tue, 02
 Feb 2021 23:09:51 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 2/3] tpm: Provide a function tpm_chip_free() to free tpm chips
Date:   Tue,  2 Feb 2021 23:09:02 +0100
Message-Id: <1612303743-29017-3-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:WjYwW2OXu8+kzUtvzXq5eYTpIyk/GgWM9rbcz0T9q4AwDg+nMOa
 MKMN2ufGdWoZ+/oKfGGVUWkruoUZFqpRh62W90/ZKyDF8R+rUOYkJ4HtA1TIHUlwe3jqz/H
 Dar4tmc8xYvyRzRZKbSEU4IQfizv7jfddi+EY0cHfGBEHUhv28CZSfKhe8XCgx6C1cRyfi4
 nu6HQFpwm9lU/7JTVoKOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BhLCDCmOtGY=:+tSUlMWbcmjbXqRXP/BPH8
 wjhhBNXPs5q8Ja05PCTbv/ZYcFrS4BxdBUTaCX0B9I4fW7wfS8PH5gZll1DU6b7poSkv5y3E3
 L20vb1tOnCaM4qJcHTRh5kJQjZkm3B3y3r9P9f6R8MkmeDROYBk9cqZdTNDzAkI4qv+oWnQnr
 MQ9mbm/6Jkg+ev2xVfM36KQsfGI8hFZDIJxh1ERabUVd4x3UBIswdfZYMvjSIR1NON8J3hcSa
 8gykTQB+nzJVrqHn6Fk/7xWbev7JIeiMCSUWUkS5olOR3q8eWESTE7RSbdv7P7UhudmlDdTmO
 TPEr3JmzO3iBNwD8iF311i6+p0OTdzX4DJhp+TJOxv9/aU373c5PMEPViE3i1L3wamYtBhhzB
 I1/eLBpn00vTgvcqCVTgNF9vzc6w7n1139s669zX+pRH4jdmyNFVBdkr4rHFHAtWm++YzCIec
 jg2gu91KZQK59nVrHC4qmCBQ5hCTex0OhfCvg/to5nK1a6b/ljYa8pYooqaHOpNr5i0v2bnRn
 X/G4xq9WqvofupoAzkRQaTxbYSigV4FD2w3oeDAHAOZyTRm89KWIM9DbMCgfXo39TIC1q0kKd
 w7+qrdl4IKn3KzU6woLMIRH0e4Vuoce0DNB11+vYidoRz1D6KOtNOSlJQqJ8zhHf/GOgTzDkS
 p2p6Uq0ONCboC1dTysyOZss07W8rvOAqtTk0b8wZFFG8M1GaYPDe/1eFjtA9GIrlFnP+v5rn2
 iGLxBYfdQSWXgxctf6oIHi3jOkbMbaUGuoVsbbKySg9J1wCzy+cHKcwBEQOS9dqBKq/+WpADR
 UgzbBYSkcefK0qmK5Kugdz5IKFZyW/RuONS+KmWkwWuViqWz48bGBeRL4NNKM4QY74s9yh23B
 xYw1iOrXn+bYvLPrZweQ==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClByb3ZpZGUg
YSBmdW5jdGlvbiB0cG1fY2hpcF9mcmVlKCkgYXMgYSBjb3VudGVycGFydCB0byB0cG1fY2hpcF9h
bGxvYygpLgpUaGUgZnVuY3Rpb24gaGlkZXMgdGhlIGludGVybmFscyBvZiBmcmVlaW5nIGEgc3Ry
dWN0IHRwbV9jaGlwIGluc3RhbmNlCmJ5IHB1dHRpbmcgdGhlIGRldmljZSByZWZlcmVuY2VzIHdo
aWNoIGFyZSBwYXJ0IG9mIHRoaXMgc3RydWN0dXJlLgoKVXNlIHRoZSBuZXcgZnVuY3Rpb24gYXQg
dGhlIGFwcHJvcHJpYXRlIHBsYWNlcy4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8
bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5j
ICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKwogZHJpdmVycy9jaGFyL3RwbS90cG0uaCAgICAg
ICAgICAgIHwgIDEgKwogZHJpdmVycy9jaGFyL3RwbS90cG1fZnRwbV90ZWUuYyAgIHwgIDYgKyst
LS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV92dHBtX3Byb3h5LmMgfCAgMyArLS0KIDQgZmlsZXMg
Y2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMK
aW5kZXggM2FjZTE5OS4uNzc3YmFhZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0t
Y2hpcC5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYwpAQCAtNDAyLDYgKzQwMiwy
MiBAQCBzdHJ1Y3QgdHBtX2NoaXAgKnRwbV9jaGlwX2FsbG9jKHN0cnVjdCBkZXZpY2UgKnBkZXYs
CiBFWFBPUlRfU1lNQk9MX0dQTCh0cG1fY2hpcF9hbGxvYyk7CiAKIC8qKgorICogdHBtX2NoaXBf
ZnJlZSgpIC0gZnJlZSBhbiBpbnN0YW5jZSBvZiBzdHJ1Y3QgdHBtX2NoaXAgdGhhdCBoYXMgYmVl
bgorICogYWxsb2NhdGVkIHdpdGggdHBtX2NoaXBfYWxsb2MoKSBiZWZvcmUuCisgKiBAY2hpcDog
Y2hpcCB0byBmcmVlCisgKgorICogRnJlZXMgYW4gaW5zdGFuY2Ugb2Ygc3RydWN0IHRwbV9jaGlw
IGJ5IHJlbGVhc2luZyBpbnRlcm5hbCBkZXZpY2UgcmVmZXJlbmNlcy4KKyAqIFRoaXMgZnVuY3Rp
b24gaXMgdXNlZCB0byBoaWRlIHRoZSBpbnRlcm5hbHMgbmVlZGVkIHRvIGZyZWUgYSBzdHJ1Y3Qg
dHBtX2NoaXAKKyAqIGluc3RhbmNlIHRoYXMgaGFzIGJlZW4gYWxsb2NhdGVkIHdpdGggdHBtX2No
aXBfYWxsb2MoKSBiZWZvcmUuCisgKi8KK3ZvaWQgdHBtX2NoaXBfZnJlZShzdHJ1Y3QgdHBtX2No
aXAgKmNoaXApCit7CisJcHV0X2RldmljZSgmY2hpcC0+ZGV2cyk7CisJcHV0X2RldmljZSgmY2hp
cC0+ZGV2KTsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKHRwbV9jaGlwX2ZyZWUpOworCisvKioKICAq
IHRwbW1fY2hpcF9hbGxvYygpIC0gYWxsb2NhdGUgYSBuZXcgc3RydWN0IHRwbV9jaGlwIGluc3Rh
bmNlCiAgKiBAcGRldjogcGFyZW50IGRldmljZSB0byB3aGljaCB0aGUgY2hpcCBpcyBhc3NvY2lh
dGVkCiAgKiBAb3BzOiBzdHJ1Y3QgdHBtX2NsYXNzX29wcyBpbnN0YW5jZQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jaGFyL3RwbS90cG0uaCBiL2RyaXZlcnMvY2hhci90cG0vdHBtLmgKaW5kZXggOTQ3
ZDFkYi4uZTZiYjZhZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0uaAorKysgYi9k
cml2ZXJzL2NoYXIvdHBtL3RwbS5oCkBAIC0xOTksNiArMTk5LDcgQEAgdm9pZCB0cG1fcHV0X29w
cyhzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApOwogCiBzdHJ1Y3QgdHBtX2NoaXAgKnRwbV9jaGlwX2Fs
bG9jKHN0cnVjdCBkZXZpY2UgKmRldiwKIAkJCQljb25zdCBzdHJ1Y3QgdHBtX2NsYXNzX29wcyAq
b3BzKTsKK3ZvaWQgdHBtX2NoaXBfZnJlZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApOwogc3RydWN0
IHRwbV9jaGlwICp0cG1tX2NoaXBfYWxsb2Moc3RydWN0IGRldmljZSAqcGRldiwKIAkJCQkgY29u
c3Qgc3RydWN0IHRwbV9jbGFzc19vcHMgKm9wcyk7CiBpbnQgdHBtX2NoaXBfcmVnaXN0ZXIoc3Ry
dWN0IHRwbV9jaGlwICpjaGlwKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX2Z0
cG1fdGVlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5jCmluZGV4IDgyODU4YzIu
LjQ3ZmZhYWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtX2Z0cG1fdGVlLmMKKysr
IGIvZHJpdmVycy9jaGFyL3RwbS90cG1fZnRwbV90ZWUuYwpAQCAtMjg1LDggKzI4NSw3IEBAIHN0
YXRpYyBpbnQgZnRwbV90ZWVfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQogCXJldHVybiAwOwog
CiBvdXRfY2hpcDoKLQlwdXRfZGV2aWNlKCZwdnRfZGF0YS0+Y2hpcC0+ZGV2KTsKLQlwdXRfZGV2
aWNlKCZwdnRfZGF0YS0+Y2hpcC0+ZGV2cyk7CisJdHBtX2NoaXBfZnJlZShjaGlwKTsKIG91dF9j
aGlwX2FsbG9jOgogCXRlZV9zaG1fZnJlZShwdnRfZGF0YS0+c2htKTsKIG91dF9zaG1fYWxsb2M6
CkBAIC0zMTksOCArMzE4LDcgQEAgc3RhdGljIGludCBmdHBtX3RlZV9yZW1vdmUoc3RydWN0IGRl
dmljZSAqZGV2KQogCXRwbV9jaGlwX3VucmVnaXN0ZXIocHZ0X2RhdGEtPmNoaXApOwogCiAJLyog
ZnJlZXMgY2hpcCAqLwotCXB1dF9kZXZpY2UoJnB2dF9kYXRhLT5jaGlwLT5kZXZzKTsKLQlwdXRf
ZGV2aWNlKCZwdnRfZGF0YS0+Y2hpcC0+ZGV2KTsKKwl0cG1fY2hpcF9mcmVlKHB2dF9kYXRhLT5j
aGlwKTsKIAogCS8qIEZyZWUgdGhlIHNoYXJlZCBtZW1vcnkgcG9vbCAqLwogCXRlZV9zaG1fZnJl
ZShwdnRfZGF0YS0+c2htKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Z0cG1f
cHJveHkuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Z0cG1fcHJveHkuYwppbmRleCA5N2I2MGY4
Li5mODg3YmIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV92dHBtX3Byb3h5LmMK
KysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdnRwbV9wcm94eS5jCkBAIC01MjAsOCArNTIwLDcg
QEAgc3RhdGljIHN0cnVjdCBwcm94eV9kZXYgKnZ0cG1fcHJveHlfY3JlYXRlX3Byb3h5X2Rldih2
b2lkKQogICovCiBzdGF0aWMgaW5saW5lIHZvaWQgdnRwbV9wcm94eV9kZWxldGVfcHJveHlfZGV2
KHN0cnVjdCBwcm94eV9kZXYgKnByb3h5X2RldikKIHsKLQlwdXRfZGV2aWNlKCZwcm94eV9kZXYt
PmNoaXAtPmRldnMpOwotCXB1dF9kZXZpY2UoJnByb3h5X2Rldi0+Y2hpcC0+ZGV2KTsgLyogZnJl
ZXMgY2hpcCAqLworCXRwbV9jaGlwX2ZyZWUocHJveHlfZGV2LT5jaGlwKTsKIAlrZnJlZShwcm94
eV9kZXYpOwogfQogCi0tIAoyLjcuNAoK
