Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:43075 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeCSDGg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Mar 2018 23:06:36 -0400
Received: by mail-pl0-f50.google.com with SMTP id f23-v6so9412076plr.10
        for <linux-integrity@vger.kernel.org>; Sun, 18 Mar 2018 20:06:35 -0700 (PDT)
MIME-Version: 1.0
From: shijun zhao <zqyzsj@gmail.com>
Date: Mon, 19 Mar 2018 11:06:34 +0800
Message-ID: <CACkgDvwwESEMmFAv=7nbiYv_H2Kt4Aq-7dDbffS4gucFNg2dDw@mail.gmail.com>
Subject: How to only measure process file
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

I'm using IMA to protect some platforms running Linux. The ima_tcb
policy is used. As we know that this policy measures all files read as
root and all file executed, including dynamic link libraries. However,
I want to measure process files only (files read as root and dynamic
link libraries will not be measured). Is it possible to define such a
policy? Or is there some other way to meet my requirement?

Thanks.
Best Regards,
