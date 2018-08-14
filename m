Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:43168 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbeHNVSt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Aug 2018 17:18:49 -0400
Date: Wed, 15 Aug 2018 04:29:55 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: David Jacobson <davidj@linux.ibm.com>
cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>
Subject: Re: [PATCH 1/7] evmtest: Regression testing Integrity Subsystem
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1808150427590.25735@namei.org>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-382548555-1534271396=:25735"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 14 Aug 2018, David Jacobson wrote:

> This patchset introduces evmtest -- a stand alone tool for regression
> testing IMA. 

Nice!

I usually run the SELinux testsuite as a general sanity check of LSM 
before pushing to Linus, and I'll also run this once it's merged.

-- 
James Morris
<jmorris@namei.org>
