Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:56234 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbeGFJq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jul 2018 05:46:27 -0400
Received: by mail-it0-f43.google.com with SMTP id 16-v6so15733259itl.5
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jul 2018 02:46:27 -0700 (PDT)
MIME-Version: 1.0
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Fri, 6 Jul 2018 10:46:15 +0100
Message-ID: <CABatt_x4bQzLuvf2iOFLBevGLx+s8tmA+m1A+q1wFECiVCReTQ@mail.gmail.com>
Subject: Question on IMA Policy
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

If I have a root filesystem signed for IMA/EVM could I have a policy
that says appraise every file on this filesystem.  Looking through the
source code I think I could use

appraise fsuuid=uuid-of-root-fs appraise_type=imasig

Would this do what I want?

Many Thanks,
Martin.
