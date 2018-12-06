Return-Path: <SRS0=uN/y=OP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C2CC04EB8
	for <linux-integrity@archiver.kernel.org>; Thu,  6 Dec 2018 23:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46320868
	for <linux-integrity@archiver.kernel.org>; Thu,  6 Dec 2018 23:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies-com.20150623.gappssmtp.com header.i=@colorremedies-com.20150623.gappssmtp.com header.b="Lly654Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E46320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLFXBh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:01:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33144 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFXBh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Dec 2018 18:01:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so1660078lfc.0
        for <linux-integrity@vger.kernel.org>; Thu, 06 Dec 2018 15:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Se74v7z/Co3YZ5jqNzAQNF/4O1cZK9luEMAEiuCN8EU=;
        b=Lly654LuVI/QNgmWDo8J9eYTtYkfAZ1NgBz6Vw+FIAeOqSnljQT+EG/PxmCIoh7VQd
         Uy1gjarCgZrFkvIeFB/b50rc3Ostx7QN7xt7fDQ7YHK4dCym/DexgeLnVhm8TmcZGvP+
         +RNIgeKSnj+CCRLCTfbXiPopf7P3Boyj/QtJXegNX//B4Sls68Xp+79hFC4TZEr0OqN/
         fQ+uwVXnH9wQGj6GQuuAB9xgUFhSc38GgImxPty357yEY88IJ3FoD+iavrkgDX59CZK4
         klBmVNIhul2/evzAQAcBRX9K7qdG0hNJey85CDkU5aPwJ0is3KOOesJ5dIWqeM65HBzS
         0nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Se74v7z/Co3YZ5jqNzAQNF/4O1cZK9luEMAEiuCN8EU=;
        b=Eoqu+/Y2qvMNoLYsmqBibbamOD+H6+/CCV+uXiqK/zQGkf2M41VmvgAtmkafAMbvkM
         yEsZZIKrqLKY4b8x9mKjotqqQKbd4SfcQfgC9fPrYsJUXSIZ7kiMnC/hRyrpH5t6Ul1j
         DhBMYg4H0KrdwLgjp2aaFZFmVvjakfdNVVhgVnKrlxfQlbbtI3y3fYnDxl/5ArI/xzXz
         4douvIMFgjiU6HWbZmQAGMLE9vyg3h2bmh+3C2GOKB3M9s3w+W85qq26QLxpHMfeBKf2
         izr/Cw2Hk9ESVs9NEh1irhSXkrrf5ko13EisGe6HgJi0enfDYsR50+gwPCR8WspbJtRc
         pl4A==
X-Gm-Message-State: AA+aEWbGjWMA9OX2Jq8ygM/zNzV+Iu+Dou76hraGMiuqSJQGRUk2KHgs
        tAE5h9CHfFDiYWmg2Lc4prmDEdsKpaSnTVbHRh1BmXgKS5c=
X-Google-Smtp-Source: AFSGD/WXDQFk4zHBGCKqCdPF5PsndWK/y1RU+oZ7gVRkLSBXXpTxAWRoEh38IJFoTmxoX2+RZ1p3FmEv3b51Bztfg0I=
X-Received: by 2002:a19:4e59:: with SMTP id c86mr19063101lfb.132.1544137295151;
 Thu, 06 Dec 2018 15:01:35 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <chris@colorremedies.com>
Date:   Thu, 6 Dec 2018 16:01:23 -0700
Message-ID: <CAJCQCtTUOh-QQgyEXu1HvHNqqL1kUEkTV3-SaWYDAduQLBhs9Q@mail.gmail.com>
Subject: unrecognized TMP 2.0 hardware
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

HP Spectre laptop, model W2K28UA, circa 2016
4.20.0-0.rc5.git2.1.fc30.x86_64
[    0.000000] DMI: HP HP Spectre Notebook/81A0, BIOS F.42 10/25/2018

[chris@flap ~]$ sudo lsmod | grep tpm
[chris@flap ~]$ dmesg | grep -i tpm
[    0.000000] efi:  SMBIOS=0x3a57a000  ESRT=0x3a57d718  ACPI
2.0=0x3affe014  PROP=0x229d0278  TPMEventLog=0x2100c018
[    0.023050] ACPI: TPM2 0x000000003AFF9000 000034 (v03 HPQOEM INSYDE
  00000000 HP   00040000)
[    2.066860] tpm_crb MSFT0101:00: can't request region for resource
[mem 0x3af5b000-0x3af5b02f]
[    2.066916] tpm_crb: probe of MSFT0101:00 failed with error -16
[    2.324683] ima: No TPM chip found, activating TPM-bypass!

Previously filed a bug here:
https://bugzilla.kernel.org/show_bug.cgi?id=185631

--
Chris Murphy
