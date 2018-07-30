Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38886 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeG3FY1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jul 2018 01:24:27 -0400
Received: by mail-it0-f49.google.com with SMTP id v71-v6so14961655itb.3
        for <linux-integrity@vger.kernel.org>; Sun, 29 Jul 2018 20:51:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532910912.4337.75.camel@linux.ibm.com>
References: <CALUj-guObu_R6--mbiNmF_ZgGNayr5Tj3pKVtW2VC3ZWWZypsg@mail.gmail.com>
 <1532910912.4337.75.camel@linux.ibm.com>
From: rishi gupta <gupt21@gmail.com>
Date: Mon, 30 Jul 2018 09:21:08 +0530
Message-ID: <CALUj-gs4Kt_L3UakwUCT=wur8CErdC57keXiHxccm+BJ6z4JtQ@mail.gmail.com>
Subject: Re: How to generate and load evm-key in TPM less systems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, zohar@linux.vnet.ibm.com,
        James Bottomley <jejb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000005cdcd505722f604e"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

<div dir="ltr">Thanks Mimi for giving insight. <span style="font-size:small;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline">Suppose I generate both master and evm-key (both are symmetric keys as per my understanding) and save them in trustzone protected area. Everytime kernel boots a driver reads these keys and loads in appropriate keyring. Will this be correct approach.</span><div><br></div><div> Because it is an existing product, TPM addition is almost impossible however I have requested team to consider including in next version of the product.<div><br></div><div><br></div></div></div><div class="gmail_extra"><br><div class="gmail_quote">On Mon, Jul 30, 2018 at 6:05 AM, Mimi Zohar <span dir="ltr">&lt;<a href="mailto:zohar@linux.ibm.com" target="_blank">zohar@linux.ibm.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">[Cc&#39;ing James Bottomley]<br>
<span class=""><br>
On Sun, 2018-07-29 at 23:46 +0530, rishi gupta wrote:<br>
&gt; Hi Integrity team,<br>
&gt; <br>
&gt; IMA is working fine in our embedded linux product and now we are trying to<br>
&gt; implement EVM. Our system does not have TPM but have trustzone and crypto<br>
&gt; engine. My question is:<br>
&gt; <br>
&gt; 1. What is the standard practice to generate and load evm-key in systems<br>
&gt; that does not have TPM.<br>
<br>
</span>TPMs are really cheap.   Convince your product group to include a TPM?<br>
<br>
&quot;encrypted&quot; keys can be decrypted either by a &quot;trusted&quot; or a &quot;user&quot;<br>
type key, but the latter is not considered safe and should be limited<br>
to test environments.<br>
<br>
Udit Agarwal recently suggested defining a new key type named &quot;secure&quot;<br>
keys, but didn&#39;t explain what made them secure.  The &quot;secure&quot; key type<br>
was limited to CAAM.<br>
<span class=""><br>
&gt; 2. Suppose we have an encrypted key which has been decrypted and loaded in<br>
&gt; kernel. Isn&#39;t it an attacker can analyse RAM and get the evm-key. Am I<br>
&gt; missing something here.<br>
<br>
</span>No, what you&#39;re saying is true.  In a secure, locked down environment<br>
analyzing kernel memory (should still) requires root privileges.<br>
<span class="HOEnZb"><font color="#888888"><br>
Mimi<br>
<br>
</font></span></blockquote></div><br></div>
