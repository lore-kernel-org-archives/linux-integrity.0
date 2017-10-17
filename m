Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756482AbdJQW0a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 18:26:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9HMOsLw022144
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 18:26:30 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dnsgfan8b-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 18:26:29 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 17 Oct 2017 23:26:27 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9HMQNG327590704
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 22:26:24 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9HMQMmZ010862
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 09:26:22 +1100
Subject: Re: [Linux-ima-devel] Centos7 execute 'su -c "keyctl pipe
 820080884"' show keyctl_read_alloc: Permission denied
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: er_tou <er_tou@163.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Tue, 17 Oct 2017 18:26:19 -0400
In-Reply-To: <639bd982.139dd.15f0072080e.Coremail.er_tou@163.com>
References: <639bd982.139dd.15f0072080e.Coremail.er_tou@163.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508279179.4513.67.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-09 at 17:23 +0800, er_tou wrote:
> 
> hello,
>     I encountered a problem, execute the following command to show the error.
> $ su -c 'mkdir -p /etc/keys'
> # To create and save the kernel master key (user type):
> $ su -c 'modprobe trusted encrypted'
> $ su -c 'keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u'
> $ su -c 'keyctl pipe `keyctl search @u user kmk-user` > /etc/keys/kmk-user.blob'
> show "keyctl_read_alloc: Permission denied".
> 
> 
> Problem location is 'keyctl pipe'.
> [root@localhost ima_key_sign]# cat /proc/keys
> 029fddf9 I------     1 perm 1f030000     0     0 asymmetri CentOS Linux kernel signing key: d48863a7c16fcc274123e6298f74f057af19fc54: X509.RSA af19fc54 []
> 034d0e68 I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid.1000: empty
> 0a1ab8e3 I--Q---     1 perm 3f010000     0     0 user      kmk-user: 10
> 
> 
> This keyring "kmk-user" don't have read permission.
> Anyone have the question ? 
> I hope get help? Thank, Thank, Thank

Sorry, I'm not seeing this problem.  Have you tried running the
commands as real root (eg. "su -"), not "su -c"?

Mimi 

> 
> ----------------------------------------------------------------------------------------
>  but, below command can execute.
> $ mkdir -p /etc/keys
> # To create and save the kernel master key (user type):
> $ modprobe trusted encrypted
> $ keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u
> $ keyctl pipe `keyctl search @u user kmk-user` > /etc/keys/kmk-user.blob
> 
> 
> Thanks,Looking forward to your reply!
> 
