Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37474 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeG2Trr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Jul 2018 15:47:47 -0400
Received: by mail-it0-f46.google.com with SMTP id h20-v6so13875754itf.2
        for <linux-integrity@vger.kernel.org>; Sun, 29 Jul 2018 11:16:30 -0700 (PDT)
MIME-Version: 1.0
From: rishi gupta <gupt21@gmail.com>
Date: Sun, 29 Jul 2018 23:46:09 +0530
Message-ID: <CALUj-guObu_R6--mbiNmF_ZgGNayr5Tj3pKVtW2VC3ZWWZypsg@mail.gmail.com>
Subject: How to generate and load evm-key in TPM less systems
To: linux-integrity@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, zohar@linux.vnet.ibm.com
Content-Type: multipart/alternative; boundary="0000000000000ea3f00572275805"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

<div dir="ltr">Hi Integrity team,<div><br></div><div>IMA is working fine in our embedded linux product and now we are trying to implement EVM. Our system does not have TPM but have trustzone and crypto engine. My question is:</div><div><br></div><div>1. What is the standard practice to generate and load evm-key in systems that does not have TPM.</div><div>2. Suppose we have an encrypted key which has been decrypted and loaded in kernel. Isn&#39;t it an attacker can analyse RAM and get the evm-key. Am I missing something here.</div><div><br></div><div>Regards,</div><div>Rishi</div></div>
