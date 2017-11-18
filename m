Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from h2.hallyn.com ([78.46.35.8]:57586 "EHLO h2.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937564AbdKREUc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 23:20:32 -0500
Date: Fri, 17 Nov 2017 22:20:30 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v2 06/15] ima: add parser of digest lists metadata
Message-ID: <20171118042030.GA13456@mail.hallyn.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <20171107103710.10883-7-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107103710.10883-7-roberto.sassu@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
> from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
> becomes available. Digest lists must be loaded before IMA appraisal is in
> enforcing mode.

I'm sure there's a good reason for it, but this seems weird to me.
Why read it from a file on disk instead of accepting it through say
a securityfile write?
