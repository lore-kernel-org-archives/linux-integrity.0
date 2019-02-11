Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26AEC169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0188214DA
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 21:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4gnmcIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBKVzY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:55:24 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41400 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBKVzY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 16:55:24 -0500
Received: by mail-vk1-f201.google.com with SMTP id q188so198991vke.8
        for <linux-integrity@vger.kernel.org>; Mon, 11 Feb 2019 13:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YVuetippqiCNoxLJuv6MIvZ0GWdtqf7nN5Z8q/y7OjA=;
        b=A4gnmcIap6hb1S/0BbnAQ4uIb6fr5HdwIweXPlZgSUTViPVlD6skMpML6p315zmbXa
         M8TP2l3LGGesaKQ1bcCWceEfsgTlQjQFN5gQXy8U1E3EO2f8+av0GgfKnr5bfcI5hiZ7
         vQc89d1j0fIDC0nXpP5yXtmUXqEFnMGKe8BkFCnFR7729IJDEYL3D0gFyw1sX6p2yRmi
         olueRQyr5H8Z8pa+IEyusceFgb8Cgeuilm0vcsS2ceTs2OGYy5+4s1K37PlfxWAGCKoL
         Qzmn6+LulzSJn3savjFAteMniepd2DtZ7j1TfOb/JQfLuKlQry3d4pr0jsNDniA5Zs29
         XOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YVuetippqiCNoxLJuv6MIvZ0GWdtqf7nN5Z8q/y7OjA=;
        b=Y/FW9li0M9MGpv2JelLbORU+ZeD/3r3rgv0Ry4ibnv2Nk5L+fZLKsgbWqw4XNte5jM
         htJNqBnW1g/SFxPexfDmiVWdwGju0FbWUj4gEkDYMwkuS5ZW4nbzLFI10AxmgxfY6BRv
         x+5L3ntWDdoyuYv5QutsFReL6G5sHV8mEOawTw9/UNd1LkRHot9PPGi2jLYWwlntEu0G
         QQDR9bn6fw81fA5LXVUhHKj9qxjPviz7nAMFRdN2rO9j/s9uPEd8BJnKBEWy1yJViPT/
         p4TANLs6ZFPZaRInfa6YDDYWPqx3F7DlS+w5+Ex6loNroUacwRuUsgOVLfDSocqTd5Pi
         NEqQ==
X-Gm-Message-State: AHQUAuapd6VD54M2EIBZr5micjmKcvRUpAtxjvnDlaGZC+MqCbk8qZkf
        MIbhVfFVmc7mjYdxQrGvGlEAqgpxojiQi/hPv3UgKDyoRliF5pTfojuDyrQ0+QMRX+tpsDsCP4a
        l+RImYaiAwtf0FUynseuogMkaf8ThSC/okx6uFuUI+xvyVmV+tFjieyX1l1bEjeeerzrG+FKkvT
        6VBkrSebId18rIK7HnY+k=
X-Google-Smtp-Source: AHgI3Ia0VSQ9HaEHd0IAzFK8MN4DXMJ7PACg9fTt7iovImTX63kggivzi9yy8j1hESzE0ZLERwWXuvIHvOF6AJpIb0xh0w==
X-Received: by 2002:ab0:348b:: with SMTP id c11mr290888uar.17.1549922123126;
 Mon, 11 Feb 2019 13:55:23 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:55:14 -0800
Message-Id: <20190211215518.81419-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH V3] Add support for TPM2 event logs on EFI systems
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Updated with review feedback comments, no functional change.


