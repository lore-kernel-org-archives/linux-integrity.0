Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:60130 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966849AbeEJSJW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 14:09:22 -0400
Date: Fri, 11 May 2018 04:09:13 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Joe Perches <joe@perches.com>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] security: encrypted-keys: Remove pr_fmt duplicate
 logging prefixes
In-Reply-To: <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
Message-ID: <alpine.LRH.2.21.1805110409080.1003@namei.org>
References: <cover.1525964381.git.joe@perches.com> <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 10 May 2018, Joe Perches wrote:

> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
> 
> Remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 63 ++++++++++++++------------------
>  1 file changed, 28 insertions(+), 35 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
